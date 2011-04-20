package {
	import org.as3commons.collections.framework.IRecursiveIterator;
	import org.as3commons.collections.iterators.RecursiveFilterIterator;
	import flash.display.Sprite;

	public class RecursiveFilterIteratorExample extends Sprite {

		public function RecursiveFilterIteratorExample() {
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
			
			var iterator : IRecursiveIterator;
			var item : Node;
			
			// All items
			
			iterator = new RecursiveFilterIterator(root, null, null);
			while (iterator.hasNext()) {
				item = iterator.next();
				trace (prefix(iterator.depth) + item);
			}

			// Node 1
			// .......Node 2
			// .......Node 3
			// Node 4
			// .......Node 5
			// .......Node 6
			// Node 7
			// .......Node 8
			// ..............Node 9
			// ..............Node 10
			// .......Node 11
			
			// Only odd items

			iterator = new RecursiveFilterIterator(
				root, oddFilter, null
			);
			while (iterator.hasNext()) {
				item = iterator.next();
				trace (prefix(iterator.depth) + item);
			}

			// Node 1
			// .......Node 3
			// Node 7
			// .......Node 11

			// Only even items

			iterator = new RecursiveFilterIterator(
				root, evenFilter, null
			);
			while (iterator.hasNext()) {
				item = iterator.next();
				trace (prefix(iterator.depth) + item);
			}

			// Node 4
			// .......Node 6

			// All items + only children of odd items

			iterator = new RecursiveFilterIterator(
				root, null, oddFilter
			);
			while (iterator.hasNext()) {
				item = iterator.next();
				trace (prefix(iterator.depth) + item);
			}

			// Node 1
			// .......Node 2
			// .......Node 3
			// Node 4
			// Node 7
			// .......Node 8
			// .......Node 11

			// All items + only children of even items

			iterator = new RecursiveFilterIterator(
				root, null, evenFilter
			);
			while (iterator.hasNext()) {
				item = iterator.next();
				trace (prefix(iterator.depth) + item);
			}

			// Node 1
			// Node 4
			// .......Node 5
			// .......Node 6
			// Node 7

			// Only items > 5

			iterator = new RecursiveFilterIterator(
				root, greater5Filter, null
			);
			while (iterator.hasNext()) {
				item = iterator.next();
				trace (prefix(iterator.depth) + item);
			}

			// Node 7
			// .......Node 8
			// ..............Node 9
			// ..............Node 10
			// .......Node 11

			// All items + only children of items > 5

			iterator = new RecursiveFilterIterator(
				root, null, greater5Filter
			);
			while (iterator.hasNext()) {
				item = iterator.next();
				trace (prefix(iterator.depth) + item);
			}

			// Node 1
			// Node 4
			// Node 7
			// .......Node 8
			// ..............Node 9
			// ..............Node 10
			// .......Node 11
		}
		
		private function oddFilter(item : *) : Boolean {
			// lets pass only odd numbers
			return Node(item).number % 2 == 1;
		}

		private function evenFilter(item : *) : Boolean {
			// lets pass only even numbers
			return Node(item).number % 2 == 0;
		}

		private function greater5Filter(item : *) : Boolean {
			// lets pass only items > 5
			return Node(item).number > 5;
		}

		private function prefix(depth : uint) : String {
			var prefix : String = "";
			for (var i : uint = 0; i < depth; i++) prefix += ".......";
			return prefix;
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
