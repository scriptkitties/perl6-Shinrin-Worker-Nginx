#! /usr/bin/env false

use v6.c;

use Config;
use JSON::Fast;
use Shinrin::Worker::Nginx::AccessLogLine;
use Shinrin::Worker::Nginx::Request;
use WWW;

sub parse-line (
	Str $in
	--> Hash:D
) is export {
	my $visit = Shinrin::Worker::Nginx::AccessLogLine.parse($in);

	if ($visit ~~ Nil) {
		die "Not a valid log line";
	}

	my $request = Shinrin::Worker::Nginx::Request.parse($visit<request>.Str);

	if (!$request) {
		die "Invalid request";
	}

	my %visit = $visit.caps.map({ .key => .value.Str });
	my %request = $request.caps.map({ .key => .value.Str });

	%(|%visit, |%request);
}

sub send-to-server (
	%data,
	Config :$config
) is export {
	my %request = %(
		collection => "nginx-access",
		data => %data
	);

	my Str $url = "{$config.get("protocol", "https")}://{$config<host>}:{$config<port>}/v1/store";

	jpost($url, to-json(%request));
}
