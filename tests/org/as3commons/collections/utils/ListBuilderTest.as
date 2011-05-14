package org.as3commons.collections.utils {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.SortedList;
	import org.as3commons.collections.framework.IList;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author John Reeves.
	 */
	public class ListBuilderTest extends TestCase {
		
		public function test_buildArrayList() : void {
			const result : IList = ListBuilder.newArrayList()
				.add("item1")
				.build();
				
			assertEquals("Resulting IList is an instance of ArrayList", getQualifiedClassName(ArrayList), getQualifiedClassName(result));
		}
		
		public function test_buildSortedList() : void {
			const result : IList = ListBuilder.newSortedList(new NumericComparator())
				.add(22)
				.add(11)
				.build();
				
			assertEquals("Resulting IList is an instance of SortedList", getQualifiedClassName(SortedList), getQualifiedClassName(result));
		}		

	}
}


