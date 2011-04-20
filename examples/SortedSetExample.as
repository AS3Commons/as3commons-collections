package {
	import org.as3commons.collections.SortedSet;
	import org.as3commons.collections.framework.ICollectionIterator;
	import org.as3commons.collections.framework.IIterator;
	import org.as3commons.collections.framework.ISetIterator;
	import flash.display.Sprite;

	public class SortedSetExample extends Sprite {

		public function SortedSetExample() {
			var theSet : SortedSet = new SortedSet(new PersonComparator());
			var erikaMeier : Person = new Person("Erika", "Meier");
			
			// Add
			
			theSet.add(new Person("Hans", "Meier"));
			theSet.add(new Person("Erika", "Meier"));
			theSet.add(new Person("Ernst", "Schmitt"));
			theSet.add(new Person("Anton", "Fischer"));
			theSet.add(new Person("Erika", "Becker"));
			theSet.add(erikaMeier);
			theSet.add(erikaMeier); // no effect (item already contained)
			
			trace (theSet.toArray());
			
			// Erika Becker
			// Anton Fischer
			// Erika Meier
			// Erika Meier
			// Hans Meier
			// Ernst Schmitt

			// Inspect
			
			trace (theSet.has(new Person("Erika", "Meier"))); // false (item not contained)
			trace (theSet.has(erikaMeier)); // true

			trace (theSet.first); // Erika Becker
			trace (theSet.last); // Ernst Schmitt

			trace (theSet.hasEqual(new Person("Ernst", "Schmitt"))); // true
			trace (theSet.hasEqual(new Person("Erika", "Schmitt"))); // false
			trace (theSet.equalItems(new Person("Erika", "Meier"))); // Erika Meier, Erika Meier

			trace (theSet.lesser(new Person("Erika", "Becker"))); // undefined
			trace (theSet.lesser(new Person("Karla", "Dieling"))); // Erika Becker
			trace (theSet.lesser(new Person("Erika", "Meier"))); // Anton Fischer
			
			trace (theSet.higher(new Person("Erika", "Meier"))); // Hans Meier
			trace (theSet.higher(new Person("Anna", "Pauli"))); // Ernst Schmitt
			trace (theSet.higher(new Person("Ernst", "Schmitt"))); // undefined
			trace (theSet.higher(new Person("Wolfgang", "Teske"))); // undefined

			// Iterator

			var iterator : IIterator = theSet.iterator();
			trace (iterator is IIterator); // true
			trace (iterator is ICollectionIterator); // true
			trace (iterator is ISetIterator); // true
			
			while (iterator.hasNext()) {
				trace (iterator.next());
			}

			// Erika Becker
			// Anton Fischer
			// Erika Meier
			// Erika Meier
			// Hans Meier
			// Ernst Schmitt

			// Remove
			
			theSet.remove(erikaMeier);
			theSet.remove(erikaMeier); // no effect (item not contained)
			
			var ernstFischer : Person = theSet.lesser(new Person("Erika", "Meier"));
			theSet.remove(ernstFischer);

			trace (theSet.toArray());
			
			// Erika Becker
			// Erika Meier
			// Hans Meier
			// Ernst Schmitt

			theSet.removeFirst();
			theSet.removeLast();

			trace (theSet.toArray());
			
			// Erika Meier
			// Hans Meier
		}
	}
}

import org.as3commons.collections.utils.StringComparator;

internal class Person {
	public var firstName : String;
	public var lastName : String;
	public function Person(first : String, last : String) {
		firstName = first;
		lastName = last;
	}
	public function toString() : String {
		return firstName + " " + lastName;
	}
}

internal class PersonComparator extends StringComparator {
	override public function compare(item1 : *, item2 : *) : int {
		var compare : int = super.compare(
			Person(item1).lastName, Person(item2).lastName
		);
		if (compare) return compare;
		return super.compare(
			Person(item1).firstName, Person(item2).firstName
		);
	}
}
