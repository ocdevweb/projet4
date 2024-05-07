#!/usr/bin/perl
 
sub process_file {
    my ($path) = @_;
    print "Processing file $path\n";
}
 
sub process_folder {
    my ($folder) = @_;
 
    # Get a directory listing
    opendir (my $dir, $folder);
    my @files = grep( /\.(?:png|gif|jpg)$/i , readdir ($dir));
    closedir ($dir);
 
    # Decide how to handle each entry
    foreach my $file (@files) {
 
        # Ignore some specific entries
        next if ($file eq ".");
        next if ($file eq "..");
 
        # Handle folders recursively
        my $path = "$folder/$file";
        if ( -d $path ) {
            process_folder($path);
            next;
        }
 
        # Handle files
        if ( -f $path) {
            process_file($path);
            next;
        }
    }
}
 
# Start in the current folder
process_folder(".");