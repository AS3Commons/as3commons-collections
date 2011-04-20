/**
 * Copyright 2010 The original author or authors.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.as3commons.collections.utils {
	import org.as3commons.collections.Map;
	import org.as3commons.collections.framework.IComparator;
	import org.as3commons.collections.framework.IMap;

	/**
	 * Array utils.
	 * 
	 * @author Jens Struwe 11.02.2009
	 */
	public class ArrayUtils {

		/**
		 * Tests if two arrays contain the same items in the same order.
		 * 
		 * @param array1 The first array.
		 * @param array2 The second array.
		 * @return <code>true</code> if both arrays contain the same items in the same order.
		 */
		public static function arraysEqual(array1 : Array, array2 : Array) : Boolean {
			if (array1 == array2) return true;

			var i : Number = array1.length;
			
			if (i != array2.length) {
				return false;
			}
			while (i--) {
				if (array1[i] !== array2[i]) {
					return false;
				}
			}
			return true;
		}

		/**
		 * Tests if two arrays contain the same items regardless of their order.
		 * 
		 * @param array1 The first array.
		 * @param array2 The second array.
		 * @return <code>true</code> if both arrays contain the same items.
		 */
		public static function arraysMatch(array1 : Array, array2 : Array) : Boolean {
			if (array1 == array2) return true;

			var i : Number = array1.length;
			if (i != array2.length) {
				return false;
			}
			
			var map : IMap = new Map();
			while (i--) {
				if (map.hasKey(array1[i])) {
					map.replaceFor(array1[i], map.itemFor(array1[i]) + 1);
				} else {
					map.add(array1[i], 1);
				}
			}

			i = array2.length;
			while (i--) {
				if (map.hasKey(array2[i])) {
					if (map.itemFor(array2[i]) == 1) {
						map.removeKey(array2[i]);
					} else {
						map.replaceFor(array2[i], map.itemFor(array2[i]) - 1);
					}
				} else {
					return false;
				}
			}
			
			return map.size == 0;
		}

		/**
		 * Sorts the given array using the insertion sort algorithm.
		 * 
		 * <p>In difference to the <code>Array.sort()</code> implemention is this sort stable which
		 * means that equal items are sorted in the same order they had in the orgininal array.</p>
		 * 
		 * <p>Faster than <code>mergeSort()</code> for very small arrays (about 10 items).</p>
		 * 
		 * @param array The array to sort.
		 * @param comparator The sort criterion.
		 * @return <code>true</code> if the array has more than 1 item.
		 */
		public static function insertionSort(array : Array, comparator : IComparator) : Boolean {
			if (array.length < 2) return false;
			var size : uint = array.length;
			for (var i : uint = 1; i < size; i++) {
				var item : * = array[i];
				var j : uint;
				for (j = i; j > 0 && comparator.compare(array[j - 1], item) == 1; --j) {
					array[j] = array[j - 1];
				}
				array[j] = item;
			}
			return true;
		}

		/**
		 * Sorts the given array using the merge sort algorithm.
		 * 
		 * <p>In difference to the <code>Array.sort()</code> implemention is this sort stable which
		 * means that equal items are sorted in the order they appear in the orgininal array.</p>
		 * 
		 * <p>Faster than <code>insertionSort()</code> for arrays greater than about 10 items.</p>
		 * 
		 * @param array The array to sort.
		 * @param comparator The sort criterion.
		 * @return <code>true</code> if the array has more than 1 item.
		 */
		public static function mergeSort(array : Array, comparator : IComparator) : Boolean {
			if (array.length < 2) return false;
			
			var firstHalf : uint = Math.floor(array.length / 2);
			var secondHalf : uint = array.length - firstHalf;
			var arr1 : Array = new Array(firstHalf);
			var arr2 : Array = new Array(secondHalf);

			var i : uint = 0;

			for (i = 0; i < firstHalf; i++) {
				arr1[i] = array[i];
			}

			for (i = firstHalf; i < firstHalf + secondHalf; i++) {
				arr2[i - firstHalf] = array[i];
			}

			mergeSort(arr1, comparator);
			mergeSort(arr2, comparator);

			i = 0;
			var j : uint = 0;
			var k : uint = 0;

			while (arr1.length != j && arr2.length != k) {
				if (comparator.compare(arr1[j], arr2[k]) != 1) {
					array[i] = arr1[j];
					i++;
					j++;
				} else {
					array[i] = arr2[k];
					i++;
					k++;
				}
			}

			while (arr1.length != j) {
				array[i] = arr1[j];
				i++;
				j++;
			}

			while (arr2.length != k) {
				array[i] = arr2[k];
				i++;
				k++;
			}

			return true;
		}
		
		/**
		 * Shuffles the items of the given array.
		 * 
		 * <p>Modern version of the Fisher-Yates algorithm.</p>
		 * 
		 * @param array The array to shuffle.
		 * @return <code>true</code> if the array has more than 1 item.
		 */
		public static function shuffle(array : Array) : Boolean {
			var i : uint = array.length;

			if (i < 2) return false;
			
			var j : uint;
			var o : *;
			while (--i) {
				j = Math.floor(Math.random() * (i + 1));
				o = array[i];
				array[i] = array[j];
				array[j] = o;
			}
			
			return true;
		}
		
	}
}
