#! /usr/bin/env false

use v6.c;

grammar Shinrin::Worker::Nginx::Request
{
	token TOP
	{
		<method> " " <url> " " <protocol>
	}

	token method
	{
		\w+
	}

	token url
	{
		\S+
	}

	token protocol
	{
		<-[ \s \" ]>+
	}
}
