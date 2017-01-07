package DataQ;
#Модуль работы с базой
use utf8;
use strict;
use DB;
use Data::Dumper;
my $database=DB->new();
my $billing_db=$database->{db};
my $telegram_db=$database->{tl_db};

sub new {
    my ($class) = @_;
    my $self = {};
    bless( $self, $class );
    return $self;
}
#Генерим токен.
sub token {
	my @cs = ("a".."z","A".."Z",0..9);
	my $token = join("",@cs[map { rand @cs } (1..13) ]);
	$token="token".$token;
	return $token;
}

sub writeuser {
        my ($uid,$login,$token)=@_;
        $telegram_db->storage->debug(1);
        $telegram_db->resultset('Token')->create({
        'uid' => $uid,
        'login' => $login,
        'token' => $token,
        });
}

#Получаем юзверей из базы биллинга. Должно вернуть uid и логин. 
#Одно из этих значений будет использоваться для дальнейшего взаимодействия пользователя с ботом
#На каждого сразу генерится токен и передаётся для записи в базу бота.
sub getusers {
	my $dbh = $telegram_db->storage->dbh->do("TRUNCATE TABLE tokens");
	my @d;
	my $sth =$billing_db->prepare(qq{select uid,login from  accounts where archive=0;});
	$sth->execute;
	while(@d=$sth->fetchrow_array()){
		writeuser($d[0],$d[1],token());
	}
	$sth->finish();
}

sub getmoney {
	my ($self,$uid)=@_;
	my $sth =$billing_db->prepare(qq{select balance from agreements where uid=$uid;});
	$sth->execute;
	return $sth->fetchrow_array();
}


sub getagr {
	my ($self,$uid)=@_;
	my @d;
	my @struc;
	my $sth =$billing_db->prepare(qq{select id,login,tr.descr,blocked from (vgroups vg,tarifs tr) where vg.uid=$uid and vg.archive=0 and vg.login!='NULL' and vg.tar_id=tr.tar_id;});
	$sth->execute;
	my $i=0;
	while(@d=$sth->fetchrow_array()){
	$struc[$i]=[$d[0],$d[1],$d[2],$d[3]];
	$i++;
	}
	return \@struc;

}

sub check_tl {
	my ($self,$tl_id)=@_;
	$telegram_db->storage->debug(1);
        my $search = $telegram_db->resultset('Active')->search({'tl_id'=>$tl_id });
	my $check = $search->single;
	my $result=0;
	if($check){
	$result=1;
	}
	return $result;
}

#Проверяем авторизацию
sub check_uid {
        my ($self,$tl_id)=@_;
        $telegram_db->storage->debug(1);
        my $search=$telegram_db->resultset('Active')->search({'tl_id'=>$tl_id });
        my $check = $search->single;
        my $result=0;
        if($check){
         $result=$check->uid;
        }
        return $result;
}

sub new_user {
        my ($self,$new)=@_;
	$telegram_db->storage->debug(1);
	$telegram_db->resultset('Active')->create({
	'tl_id'=>$new->[1],
	'tl_nick'=>$new->[2],
	'tl_name'=>$new->[3]
	});
	
}

#Чекаем прилетевший токен. На вход токен, на выход uid
sub check_tk {
	 my ($self,$token)=@_;
        $telegram_db->storage->debug(1);
        my $search=$telegram_db->resultset('Token')->search({'token'=> $token });
	my $check = $search->single;
	my $result=0;
	if($check){
		$result=$check->uid;
	}
	return $result;
}

#Добавляем uid соответствующий телеграм аккаунту
sub add_uid {
        my ($self,$uid,$tl_id)=@_;
	$telegram_db->storage->debug(1);
	$telegram_db->resultset('Active')->search({'tl_id'=>$tl_id})->update({'uid'=>$uid});
}
1;
