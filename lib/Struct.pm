package Struct;
#Обработка полученных данных
use utf8;
use strict;
use DataQ;
use Data::Dumper;

sub new {
    my ($class) = @_;
    my $self = {};
    bless( $self, $class );
    return $self;
}

my $data=DataQ->new();

sub agr_type {
	my $id=shift;
	my %list_agr=(
		1=>"Интернет",
		2=>"Телефония",
		6=>"Телевидение",
		7=>"Vlan"
	);
	return $list_agr{$id};
}

sub block_type {
	my $id=shift;
	my %list=(
		0=>"Активна",
		1=>"Заблокирована по балансу",
		2=>"Заблокирована пользователем",
		3=>"Заблокирована администратором",
		4=>"Заблокирована по балансу",
		5=>"Превышен лимит",
		10=>"Учётная запись отключена"
		);
        return $list{$id};
}

sub struc_money {
        my ($self,$msg)=@_;
	my $text;
        my $uid=$data->check_uid($msg->[1]);
	if($uid and $uid ne '0'){
		$text="=========\nВаш баланс:\n".sprintf("%.2f",$data->getmoney($uid))." Рублей\n=========\n";
	}
	else{
		$text="Вы не авторизованы! Пришлите полученный токен";
	}	
	return $text;
}

sub struc_agr {
	my ($self,$msg)=@_;
	my $text;
        my $uid=$data->check_uid($msg->[1]);
	if($uid and $uid ne '0'){
		my @list=@{$data->getagr($uid)};
		for(my $i=0;$i<=$#list;$i++){
			if($list[$i]->[0] eq '1'){
			#print Dumper(agr_type($list[$i]->[0]));
			$text.="+++++++\nУслуга:" . agr_type($list[$i]->[0]) . "\nСтатус:" . block_type($list[$i]->[3]) . "\nЛогин:" . $list[$i]->[1] . "\nТариф:" . $list[$i]->[2] . "\n";
			}
			else{
               		 $text.="+++++++\nУслуга:" . agr_type($list[$i]->[0]) . "\nСтатус:" . block_type($list[$i]->[3]) . "\nЛогин:" . $list[$i]->[1] . "\n";
			}
		}
	}
	else
	{$text="Вы не авторизованы! Пришлите полученный токен";}
return $text;
}

sub str_start {
        my ($self,$msg)=@_;
	my $stat=$data->check_tl($msg->[1]);
	my $text;
	if($stat eq '0'){
		$data->new_user($msg);
		$text="Приветствую ".$msg->[2]." !!! Для дальнейшей работы необходимо прислать полученный токен вида tokenTkKGjvkdsagKI";
	}
	else {
		$text="Введите /help для получения списка доступных функций";
	}
return $text;
}

sub some_fn {
        my ($self,$msg)=@_;
	my $stat=$data->check_tl($msg->[1]);
	my $text;
	if($stat eq '0'){
		$text="Unknown user ".$msg->[2];
	}
	else{
		if($msg->[0]=~/token/){
			my $che=$data->check_tk($msg->[0]);
			if($che eq '0'){
				$text="Token is incorrect";
			}
			else {
				$data->add_uid($che,$msg->[1]);
				$text="Поздравляю, вы авторизованы! Введите /help для получения списка доступных функций!";
			}
		}
		else {
			$text="Unknown command. Введите /help для получения списка доступных функций!";
		}
	}
return $text;
}

	
1;
