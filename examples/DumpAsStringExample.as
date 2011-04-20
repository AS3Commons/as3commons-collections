package {
	import org.as3commons.collections.utils.CollectionUtils;
	import flash.display.Sprite;

	public class DumpAsStringExample extends Sprite {

		public function DumpAsStringExample() {
			var root : Node = new Node(0);
			var child1 : Node = new Node(1);
			child1.children = [new Node(2), new Node(3)];
			var child2 : Node = new Node(4);
			child2.children = [new Node(5), new Node(6)];
			var child3 : Node = new Node(7);
			var child4 : Node = new Node(8);
			child4.children = [new Node(9), new Node(10)];
			child3.children = [child4, new Node(11)];
			root.children = [child1, child2, child3];
			
			trace (CollectionUtils.dumpAsString(root));

			// Node 0
			// .......Node 1
			// ..............Node 2
			// ..............Node 3
			// .......Node 4
			// ..............Node 5
			// ..............Node 6
			// .......Node 7
			// ..............Node 8
			// .....................Node 9
			// .....................Node 10
			// ..............Node 11
		}
	}
}

import org.as3commons.collections.framework.IIterable;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.iterators.ArrayIterator;

internal class Node implements IIterable {
	public var number : uint;
	public var children : Array;
	public function Node(theNumber : uint) {
		number = theNumber;
		children = new Array();
	}
	public function iterator(cursor : * = undefined) : IIterator {
		return new ArrayIterator(children);
	}
	public function toString() : String {
		return "Node " + number.toString();
	}
}
