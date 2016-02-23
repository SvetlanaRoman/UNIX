BEGIN{
	FS ="_"
}
{	
	if ($2 == "10.10.2006")
	{ print $1
	}
}
