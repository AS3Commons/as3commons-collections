package {
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.LinkedList;
	import org.as3commons.collections.Map;
	import org.as3commons.collections.utils.Lists;
	import flash.display.Sprite;

	public class ListsAddFromExample extends Sprite {

		public function ListsAddFromExample() {
			// list to populate
			var list : ArrayList = new ArrayList();

			// from array (ordered)
			var a : Array = [1, "2", "2"];
			Lists.addFromArray(list, a);

			// from linked list (ordered)
			var l : LinkedList = new LinkedList();
			l.add("2");
			l.add(3);
			l.add("4");
			l.add(3);
			Lists.addFromCollection(list, l);

			// from map (no order)
			var m : Map = new Map();
			m.add("five", 5);
			m.add("six", "6");
			m.add("four", "4");
			Lists.addFromCollection(list, m);

			// from args (ordered)
			Lists.addFromArgs(list,
				7, "8", "8", 5
			);

			// test
			trace (list.toArray().join("\n"));
			
			//	1			// from array
			//	2
			//	2
			//	2			// from linked list
			//	3
			//	4
			//	3
			//	4			// from map
			//	6
			//	5
			//	7			// from args
			//	8
			//	8
			//	5
		}

	}
}