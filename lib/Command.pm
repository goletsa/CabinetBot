package Command;
#Коммандный пункт
use utf8;
use strict;
use Data::Dumper;
use Struct;

sub new {
    my ($class) = @_;
    my $self = {};
    bless( $self, $class );
    return $self;
}

my $struct=Struct->new;
my $sender=sub {
	my ($api,$id,$rec)=@_;
	$api->SendMessage({
                chat_id => $id,
                text    => $rec 
                });
};

sub start {
	my ($self,$api,$msg)=@_;
#	print Dumper($self,$api,$msg);
        print "start function:".$msg->[0]." ".$msg->[1]." ".$msg->[2]." ".$msg->[3]."\n";
	 if($msg->[1] && $msg->[2]){
         my $rec=$struct->str_start($msg);
        $sender->($api,$msg->[1],$rec);
        }

}

sub money {
        my ($self,$api,$msg)=@_;
        # print Dumper($self,$api,$msg);
	 print "money function:".$msg->[0]." ".$msg->[1]." ".$msg->[2]." ".$msg->[3]."\n";
	 if($msg->[1] && $msg->[2]){
         my $rec=$struct->struc_money($msg);
        $sender->($api,$msg->[1],$rec);
        }
}


sub info {
        my ($self,$api,$msg)=@_;
        #print Dumper($self,$api,$msg);
        print "info function:".$msg->[0]." ".$msg->[1]." ".$msg->[2]." ".$msg->[3]."\n";
	 if($msg->[1] && $msg->[2]){
         my $rec=$struct->struc_agr($msg);
        $sender->($api,$msg->[1],$rec);
        }


}

sub stop {
        my ($self,$api,$msg)=@_;
       # print Dumper($self,$api,$msg);
        print "stop function:".$msg->[0]." ".$msg->[1]." ".$msg->[2]." ".$msg->[3]."\n";
	 if($msg->[1] && $msg->[2]){
         my $rec=$struct->some_fn($msg);
        $sender->($api,$msg->[1],$rec);
        }
}

sub help {
        my ($self,$api,$msg)=@_;
        print "help function:".$msg->[0]." ".$msg->[1]." ".$msg->[2]." ".$msg->[3]."\n";
         if($msg->[1] && $msg->[2]){
        $sender->($api,$msg->[1],"Command list: /info /money");
        }
}

sub AUTOLOAD {
        my ($self,$api,$msg)=@_;
#        print Dumper($self,$api,$msg);
	print "AUTOLOAD function:".$msg->[0]." ".$msg->[1]." ".$msg->[2]." ".$msg->[3]."\n";
	if($msg->[1] && $msg->[2]){
	 my $rec=$struct->some_fn($msg);
        $sender->($api,$msg->[1],$rec);
	}
}

1;
