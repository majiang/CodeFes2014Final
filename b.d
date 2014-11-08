import std.stdio, std.array, std.algorithm, std.range, std.random, std.typecons;
import std.conv : to;
import std.string : strip, format;
import std.functional : memoize;
import std.exception : enforce;

void main()
{
	auto x = read!string();
	int sum;
	int sgn = 1;
	foreach (i; 0..x.length)
	{
		sum += sgn * x[i..i+1].to!int();
		sgn *= -1;
	}
	sum.writeln();
}

T read(T)()
{
	return readln().strip().to!T();
}

T[] readMany(T)()
{
	return readln().strip().split().map!(to!T)().array();
}

auto readTuple(T...)()
{
	return readln().strip().split().parseTuple!T();
}

auto parseTuple(T...)(string[] x)
{
	static if (T.length == 0)
	{
		(x.length == 0).enforce("Expecting empty string[] but received %s".format(x));
		return tuple();
	}
	else
		return tuple(x[0].to!(T[0]), x[1..$].parseTuple!(T[1..$])().expand);
}
