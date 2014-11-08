import std.stdio, std.array, std.algorithm, std.range, std.random, std.typecons;
import std.conv : to;
import std.string : strip, format;
import std.functional : memoize;
import std.exception : enforce;

/// Let x = sum(10^i x[i]). Then f(x) = sum(x^i x[i]).
auto f(in int x)
{
	ulong sum;
	foreach (d; x.to!string().map!(c => c.to!int() - 0x30)().array())
	{
		sum *= x;
		sum += d;
	}
	return sum;
}

int binary_search(ulong y, int xmin, int xmax)
{
	if (f(xmin) == y)
		return xmin;
	if (f(xmax) == y)
		return xmax;
	if (xmin + 1 == xmax)
		return -1;
	auto xmid = xmin + ((xmax-xmin) >> 1);
	if (f(xmid) == y)
		return xmid;
	if (f(xmid) < y)
		return binary_search(y, xmid, xmax);
	if (y < f(xmid))
		return binary_search(y, xmin, xmid);
	assert (false);
}

void main()
{
	auto y = read!ulong();
	binary_search(y, 10, 1_0000_0000).writeln();
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
