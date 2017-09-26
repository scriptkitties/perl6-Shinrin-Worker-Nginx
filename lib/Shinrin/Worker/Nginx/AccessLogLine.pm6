#! /usr/bin/env false

use v6.c;

grammar Shinrin::Worker::Nginx::AccessLogLine
{
	token TOP
	{
		<ip> " - - [" <datetime> "] \"" <request> "\" " <status-code> " " <size> " \"" <-[ \" ]>+ "\" \"" <user-agent> "\""
	}

	token ip
	{
		\d+\.\d+\.\d+\.\d+
	}

	token datetime
	{
		\d+\/\w+\/\d+\:\d+\:\d+\:\d+ " +" \d+
	}

	token request
	{
		<-[ \" ]>+
	}

	token status-code
	{
		\d ** 3
	}

	token size
	{
		\d+
	}

	token user-agent
	{
		<-[ \" ]>+
	}
}
