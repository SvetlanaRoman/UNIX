BEGIN{
	sum = 0
}
{
	p = NF - 1
	sum = sum  + $NF * $p
}
END{
	printf "В магазине ЦУМ 10.10.2006 было совершено покупок на сумму %.2f рублей\n",  sum
}
