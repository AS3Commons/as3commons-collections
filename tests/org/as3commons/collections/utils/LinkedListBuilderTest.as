package org.as3commons.collections.utils {

	import flexunit.framework.TestCase;

	import org.as3commons.collections.LinkedList;
	import org.as3commons.collections.framework.ILinkedList;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author John Reeves.
	 */
	public class LinkedListBuilderTest extends TestCase {
		
		public function test_buildLinkedList() : void {
			const result : ILinkedList = LinkedListBuilder.newLinkedList()
				.add("item1")
				.build();
				
			assertEquals("Resulting IList is an instance of LinkedList", getQualifiedClassName(LinkedList), getQualifiedClassName(result));
		}
		
	}
}


