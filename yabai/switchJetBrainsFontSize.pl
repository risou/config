use strict;
use warnings;
use XML::LibXML;

my $size = $ARGV[0] // 18;

my $editor_font_file = "$ENV{HOME}/Library/Application Support/JetBrains/GoLand2024.1/options/editor-font.xml";
my $ui_font_file = "$ENV{HOME}/Library/Application Support/JetBrains/GoLand2024.1/options/other.xml";

sub modify_editor_font_size {
    my $parser = XML::LibXML->new();
    my $doc = $parser->parse_file($editor_font_file);

    foreach my $option ($doc->findnodes('//option')) {
        my $name = $option->getAttribute('name');
        if ($name eq 'FONT_SIZE' || $name eq 'FONT_SIZE_2D') {
            $option->setAttribute('value', $size);
        }
    }

    open my $out, '>',  $editor_font_file or die "Can't open file for writing: $!";
    print $out $doc->toString();
    close $out;
}

sub modify_ui_font_size {
    my $parser = XML::LibXML->new();
    my $doc = $parser->parse_file($ui_font_file);

    foreach my $component ($doc->findnodes("//component[\@name='NotRoamableUiSettings']")) {
        foreach my $option ($component->findnodes(".//option[\@name='fontSize']")) {
            $option->setAttribute('value', sprintf("%.1f", $size));
        }
    }

    open my $out, '>', $ui_font_file or die "Can't open file for writing: $!";
    print $out $doc->toString();
    close $out;
}

sub stop_goland {
    my $wait = <<'EOS';
osascript -e 'tell application "System Events"' \
-e 'repeat while (application process "GoLand" exists)' \
-e '	delay 0.5' \
-e 'end repeat' \
-e 'end tell'
EOS
    system($wait);
    system("osascript -e 'quit app \"GoLand\"' >/dev/null 2>&1");
    sleep(3);

    my $ps_command = `ps aux | grep -i 'GoLand.app' | grep -v 'fsnotifier' | grep -v 'fish-integration' | grep -v grep`;
    my @lines = split /\n/, $ps_command;
    foreach my $line (@lines) {
        if ($line =~ m/.*GoLand.*goland$/) {
            my @parts = split /\s+/, $line;
            my $pid = $parts[1]; # プロセスID

            # プロセスを強制終了
            system("kill $pid");
            sleep(3);
        }
    }
}

sub start_goland {
    system("open -a GoLand.app");
}

stop_goland();
modify_editor_font_size();
modify_ui_font_size();
start_goland();
