import std.stdio, std.array, std.algorithm, std.range, std.random, std.typecons;
import std.conv : to;
import std.string : strip, format;
import std.functional : memoize;
import std.exception : enforce;

void main()
{
	read!int().writeln();
	readMany!int().writeln();
	readTuple!(string, int, float)().writeln();
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
