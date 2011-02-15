#!/usr/bin/perl

use strict;
use warnings;

use File::Touch;

#file with references for each department

#gets full list of directories, except '.' and '..' pseudo-dirs
opendir DIR_DEPTS, 'departamentos' or die "Error opening folder\n";
my @depts = grep {!/^[\.]+$/} (readdir DIR_DEPTS);
close DIR_DEPTS;

#creates content for content.tex on main dir
print "Creating content.tex\n";
open MAIN_REFS, '>', 'content.tex';
foreach (@depts) {
	print "Adding reference for $_\n";
	print MAIN_REFS "\\newpage\n";
	print MAIN_REFS "\\input{departamentos/$_/main}\n";
	print MAIN_REFS "\\input{departamentos/$_/activities}\n";
	handle_dept($_);
}
close MAIN_REFS;

sub handle_dept {
	my $dept = $_[0];

	print "Handling activities for $dept:\n";

	#reads all tex files from department folder, except main.tex and activities.tex
	opendir DIR_DEPT, "departamentos/$dept" or die "Error handling departamentos/$dept folder";
	my  @activities = grep {/^.+\.tex$/ && $_ ne 'activities.tex' && $_ ne 'main.tex'} (readdir DIR_DEPT);

	#creates references for each activitie of current department
	print "\tCreating departamentos/$dept/activities.tex\n";
	open DEPT_REFS, '>', "departamentos/$dept/activities.tex";
	foreach (@activities) {
		print "\tAdding reference for file $_\n";
		print DEPT_REFS "\\input{departamentos/$dept/$_}\n";
	}
	close DEPT_REFS;
}
