use lib '../lib';
use LSWG::Model::Schema;
use DateTime;
use utf8;

my $schema = LSWG::Model::Schema->connect('dbi:SQLite:my.db');
#$schema->deploy();

my $rs = $schema->resultset('Post');
#INSERT INTO posts (author, title, content, date_published) VALUES('first', ...)
$rs->create({
	author => 'Max First',
	title => '你好',
	content => '世界',
	date_published => DateTime->now,
});

my @all = $schema->resultset('Post')->all;

foreach my $a (@all) {
    print $a->author,"\n";
    print $a->title,"\n";
    print $a->content,"\n";
    print $a->date_published,"\n";
}
