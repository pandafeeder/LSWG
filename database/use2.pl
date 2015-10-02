use lib '../lib';
use LSWG::Model::Schema;
use DateTime;
use utf8;

my $schema = LSWG::Model::Schema->connect('dbi:SQLite:pass.db');
$schema->deploy();

#my $rs = $schema->resultset('Pass');
##INSERT INTO posts (author, title, content, date_published) VALUES('first', ...)
#$rs->create({
#	username => 'abcdef',
#	password => "111111",
#});
#
#my @all = $schema->resultset('Pass')->all;
#
#foreach my $a (@all) {
#    print $a->password,"\n";
#    print $a->username,"\n";
#}
