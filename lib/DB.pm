package DB;
#Модуль с коннектами к базам.

use utf8;
use strict;
use ConfigTl;
use Teleg::Schema;
use DBI;
use Carp;

my $config = ConfigTl->new({});

sub new {
    my ($class) = @_;
    my $self = {};
    bless( $self, $class );
    $self->{config} = $config->config();
    $self->{db} = $self->getDBI();
    $self->{tl_db} = $self->getSch();
    return $self;
}

sub getDBI {
        my $self = shift;
	my $dbh = undef;
	my $dbconf = $self->{config};
	eval {
		$dbh = DBI->connect( 
			"DBI:$dbconf->{dbtype}:database=$dbconf->{dbname};host=$dbconf->{dbhost};port=$dbconf->{dbport}", 
			$dbconf->{dbuser},$dbconf->{dbpass}, 
			{RaiseError => 1, PrintError => 1, mysql_enable_utf8 => 1} 
		);
	};
    if ($@) {	
		if (DBI->errstr) {
			carp("DBI->connect() failed with error '".DBI->errstr."'");
			return undef; # ???
		}
        else {
            carp("DBI->connect() failed with error '".$@."'.");
            return undef;
        }
	}
    return $dbh;
}

sub getSch {
	my $self = shift;
        my $schema = undef;
        my $dbconf = $self->{config};
	eval {
	 $schema = Teleg::Schema->connect(
	                        "DBI:$dbconf->{tl_dbtype}:database=$dbconf->{tl_dbname};host=$dbconf->{tl_dbhost};port=$dbconf->{tl_dbport}",
				$dbconf->{tl_dbuser},$dbconf->{tl_dbpass}, 
				{quote_names => 1, mysql_enable_utf8 => 1, }
		);
	};
	if ($@) {
            carp("Teleg::Schema->connect() failed with error '".$@."'.");
            return undef;
        }
    return $schema;
}


1;
