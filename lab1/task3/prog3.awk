BEGIN{
	FS = "_"
}
{
	if ($1 == "ЦУМ")
	{
		print $2
	}
}
