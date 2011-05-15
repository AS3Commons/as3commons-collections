package {
	import org.as3commons.collections.LinkedList;
	import org.as3commons.collections.LinkedSet;
	import org.as3commons.collections.Map;
	import org.as3commons.collections.utils.Sets;
	import flash.display.Sprite;

	public class SetsAddFromExample extends Sprite {

		public function SetsAddFromExample() {
			// set to populate
			var theSet : LinkedSet = new LinkedSet();

			// from array (ordered)
			var a : Array = [1, "2", "2"]; // second "2" ignored by set
			Sets.addFromArray(theSet, a);

			// from linked list (ordered)
			var l : LinkedList = new LinkedList();
			l.add("2"); // ignored by set
			l.add(3);
			l.add("4");
			l.add(3); // ignored by set
			Sets.addFromCollection(theSet, l);

			// from map (no order)
			var m : Map = new Map();
			m.add("five", 5);
			m.add("six", "6");
			m.add("four", "4"); // ignored by set
			Sets.addFromCollection(theSet, m);

			// from args (ordered)
			Sets.addFromArgs(theSet,
				7, "8", "6" // "6" ignored by set
			);

			// test
			trace (theSet.toArray().join("\n"));
			
			//	1			// from array
			//	2
			//	3			// from linked list
			//	4
			//	6			// from map
			//	5
			//	7			// from args
			//	8
		}

	}
}