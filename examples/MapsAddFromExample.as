package {
	import org.as3commons.collections.LinkedMap;
	import org.as3commons.collections.framework.IMapIterator;
	import org.as3commons.collections.utils.Maps;
	import flash.display.Sprite;
	import flash.utils.Dictionary;

	public class MapsAddFromExample extends Sprite {

		public function MapsAddFromExample() {
			// map to populate
			var map : LinkedMap = new LinkedMap();

			// from object (no order)
			var o : Object = {
				1: "1",
				"2": "two"
			};
			Maps.addFromObject(map, o);

			// from dictionary (no order)
			var d : Dictionary = new Dictionary();
			d["2"] = "two (2)"; // ignored by map
			d[3] = "3";
			d["4"] = "four";
			Maps.addFromObject(map, d);

			// from array (ordered)
			var a : Array = [
				3, "3 (2)", // ignored by map
				5, "5",
				"6", "six"
			];
			Maps.addFromArray(map, a);

			// from map (ordered)
			var m : LinkedMap = new LinkedMap();
			m.add("6", "six (2)"); // ignored by map
			m.add(7, "7");
			m.add("8", "eight");
			Maps.addFromMap(map, m);

			// from args (ordered)
			Maps.addFromArgs(map,
				"8", "eight (2)", // ignored by map
				9, "9",
				"10", "ten"
			);

			// test
			var i : IMapIterator = map.iterator() as IMapIterator;
			while (i.next()) trace (i.key, "=>", i.current);
			
			//	1 => 1			// from object
			//	2 => two
			//	4 => four		// from dictionary
			//	3 => 3
			//	5 => 5			// from array
			//	6 => six
			//	7 => 7			// from linked map
			//	8 => eight
			//	9 => 9			// from args
			//	10 => ten
		}

	}
}