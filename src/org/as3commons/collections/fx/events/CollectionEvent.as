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
package org.as3commons.collections.fx.events {
	import org.as3commons.collections.framework.ICollectionIterator;

	import flash.events.Event;

	/**
	 * Bindable collection base event.
	 * 
	 * <p><strong>Description</strong></p>
	 * 
	 * <p>The <code>CollectionEvent</code> is the base class of all events dispatched
	 * by the bindable collections in this library.</p>
	 * 
	 * <p>A collection event is either an atomic or a bulk change notification.</p>
	 * 
	 * <p>Atomic changes are dispatched after items have been added, removed or replaced.
	 * Atomic change notifications enable a listener to incrementally update its
	 * internal representation of the collection's state. To locate the position
	 * of an insertion, removal or replace operation, the collection event is
	 * equipped with a preinitialised iterator which points to the affected item
	 * (insert, replace) or its successor (remove).</p>
	 * 
	 * <p>Bulk changes are dispatched after drastical modifications that can not be expressed
	 * in atomic insertion, removal or replacement events (clear, sort, reverse). Bulk change notifications
	 * require the listener to fully update its internal representation of the collection's state.
	 * A bulk notification does not provide an event iterator.</p>
	 * 
	 * <p><strong>Features</strong></p>
	 * 
	 * <p>A collection event consists of a set of useful properties to reconstruct and reflect
	 * the modifications made to a collection.</p>
	 * 
	 * <ul>
	 * <li><code>kind</code> - The particular kind of the change.</li>
	 * <li><code>numItems</code> - The number of items affected (added, removed, replaced).</li>
	 * <li><code>item</code> - The item that has been added, removed or the replacing item (if single item) or<br />
	 * <code>items</code> - The items that have been added or removed (if multiple items).</li>
	 * <li><code>iterator()</code> - An iterator pointing to the position of the add, remove or replace
	 * operation.</li>
	 * </ul>
	 * 
	 * <p><strong>Event kinds</strong></p>
	 * 
	 * <p>A collection event has only one event type <code>CollectionEvent.COLLECTION_CHANGED</code>.
	 * The kind of the event can be distinguished by the event <code>kind</code> property.</p>
	 * 
	 * <ul>
	 * <li><code>CollectionEvent.ITEM_ADDED</code> - An item (or a number of items) has been added.</li>
	 * <li><code>CollectionEvent.ITEM_REPLACED</code> - The item a specific position has been replaced.</li>
	 * <li><code>CollectionEvent.ITEM_REMOVED</code> - An item (or a number of items) has been removed.</li>
	 * <li><code>CollectionEvent.RESET</code> - The collection has been changed so drastically that atomic add,
	 * replace or remove events do not suffice (clear, sort, reverse or any other reset).</li>
	 * </ul>
	 * 
	 * <p><strong><code>CollectionEvent</code> subclasses</strong></p>
	 * 
	 * <p>To reflect its particular semantic, each bindable collection dispatch its custom specialised
	 * form of the <code>CollectionEvent</code>. The custom events add distinctive access properties
	 * such as index, item or key. You need to downcast the general CollectionEvent to the event type
	 * of the particular collection to access the additional properties.</p>
	 * 
	 * <p><strong>Event iterator</strong></p>
	 * 
	 * <p>The iterator returned by this event's <code>iterator()</code> method has always the same type as
	 * the iterator returned by the iterator returned by the event dispatching collection's
	 * <code>iterator()</code> method and can be safely downcasted to this interface.</p>
	 * 
	 * <p id="link_CollectionEventDowncastExample"><strong>Event downcast example</strong></p>
	 * 
	 * {{EXAMPLE: CollectionEventDowncastExample}}
	 * 
	 * <p id="link_CollectionEventIteratorExample"><strong>Event iterator example</strong></p>
	 * 
	 * {{EXAMPLE: CollectionEventIteratorExample}}
	 * 
	 * <p id="link_CollectionEventIteratorDownCastExample"><strong>Event iterator downcast example</strong></p>
	 * 
	 * {{EXAMPLE: CollectionEventIteratorDownCastExample}}
	 * 
	 * @author Jens Struwe 01.03.2010
	 */
	public class CollectionEvent extends Event {

		/**
		 * Event type of all collection events.
		 * 
		 * <p>Dispatched after all modifications of the collection.</p>
		 * 
		 * <table class="innertable">
		 * 
		 * <tr>
		 * <th>Property</th>
		 * <th>Value</th>
		 * </tr>
		 * 
		 * <tr>
		 * <td>type</td>
		 * <td>CollectionEvent.COLLECTION_CHANGED</td>
		 * </tr>
		 * 
		 * <tr>
		 * <td>kind</td>
		 * <td>CollectionEvent.ITEM_ADDED - Item (or items) has been added.<br />
		 * CollectionEvent.ITEM_REPLACED - Item has been replaced.<br />
		 * CollectionEvent.ITEM_REMOVED - Item (or items) has been removed.<br />
		 * CollectionEvent.RESET - Collection has changed drastically.</td>
		 * </tr>
		 * 
		 * <tr>
		 * <td>item<br />
		 * items</td>
		 * <td>The item that has been added, removed or the replacing item (singular operation).<br />
		 * The items that have been added or removed (bulk operation).</td>
		 * </tr>
		 * 
		 * <tr>
		 * <td>numItems</td>
		 * <td>The number of items added, removed or replaced.</td>
		 * </tr>
		 * 
		 * <tr>
		 * <td>iterator()</td>
		 * <td>Iterator pointing to the position of an insertion, replacement or removal operation.</td>
		 * </tr>
		 * 
		 * <tr>
		 * <th colspan="2">ListEvent</th>
		 * </tr>
		 * 
		 * <tr>
		 * <td>list<br />
		 * index</td>
		 * <td>The event dispatching list.<br />
		 * The position of the item added, removed or replacing.</td>
		 * </tr>
		 * 
		 * <tr>
		 * <th colspan="2">SetEvent</th>
		 * </tr>
		 * 
		 * <tr>
		 * <td>set</td>
		 * <td>The event dispatching set.</td>
		 * </tr>
		 * 
		 * <tr>
		 * <th colspan="2">MapEvent</th>
		 * </tr>
		 * 
		 * <tr>
		 * <td>map<br />
		 * key</td>
		 * <td>The event dispatching map.<br />
		 * The key of the item added, removed or replacing.</td>
		 * </tr>
		 * 
		 * </table>
		 * 
		 * @eventType collectionChanged
		 */
		public static var COLLECTION_CHANGED : String = "collectionChanged";
		
		/**
		 * Event kind of an item insertion event.
		 * 
		 * <p>Dispatched after a single item or a list of items have been added
		 * at a specific position.</p>
		 */
		public static var ITEM_ADDED : String = "itemAdded";

		/**
		 * Event kind of an item replacement event.
		 * 
		 * <p>Dispatched after the item at a specific position has been replaced.</p>
		 */
		public static var ITEM_REPLACED : String = "itemReplaced";

		/**
		 * Event kind of an item removal event.
		 * 
		 * <p>Dispatched after a single item or a number of items have been removed
		 * from a specific position.</p>
		 */
		public static var ITEM_REMOVED : String = "itemRemoved";
		
		/**
		 * Event kind of collection reset events.
		 * 
		 * <p>Dispatched if the collection has been changed completely. E.g. after all
		 * items have been removed <code>clear()</code> or the underlying data source
		 * has been replaced <code>arrayList.array = newArray;</code> or multiple modification
		 * have been made in one step (<code>reverse(), sort()</code>).</p>
		 */
		public static var RESET : String = "reset";

		/**
		 * The event kind.
		 */
		public var kind : String;

		/**
		 * The affected item.
		 * 
		 * <p>Only set for the event kinds <code>CollectionEvent.ITEM_ADDED</code>,
		 * <code>CollectionEvent.ITEM_REPLACED</code>, ITEM_REMOVED.</p>
		 * 
		 * <p>Only set if the event is a result of a singular modification such as
		 * <code>add(), addAt(), replaceAt(), remove(), removeAt()</code> and not after
		 * bulk operations such as <code>addAllAt(), removeAllAt()</code>. In the latter
		 * case, the property <code>items</code> is set instead.</p>
		 */
		public var item : *;

		/**
		 * The affected items.
		 * 
		 * <p>Only set for the event kinds <code>CollectionEvent.ITEM_ADDED</code>,
		 * <code>CollectionEvent.ITEM_REPLACED</code>, <code>CollectionEvent.ITEM_REMOVED</code>.</p>
		 * 
		 * <p>Only set if the event is a result of a bulk operation such as <code>addAllAt(),
		 * removeAllAt()</code> and not after a singular modification such as <code>add(), addAt(),
		 * replaceAt(), remove(), removeAt()</code>. In the latter case, the property <code>item</code>
		 * is set instead.</p>
		 */
		public var items : Array;

		/**
		 * Number of added or removed items.
		 * 
		 * <p>Only set for the event kinds <code>CollectionEvent.ITEM_ADDED</code>,
		 * <code>CollectionEvent.ITEM_REPLACED</code>, <code>CollectionEvent.ITEM_REMOVED</code>.</p>
		 * 
		 * <p><code>-1</code> if the event kind is <code>CollectionEvent.RESET</code>.</p>
		 */
		public var numItems : int;
		
		/**
		 * CollectionEvent constructor.
		 */
		public function CollectionEvent() {
			super(COLLECTION_CHANGED);
		}
		
		/**
		 * Returns an iterator pointing to the position of the affected item.
		 * 
		 * <p>Only set for the event kinds <code>CollectionEvent.ITEM_ADDED</code>,
		 * <code>CollectionEvent.ITEM_REPLACED</code>, <code>CollectionEvent.ITEM_REMOVED</code>.</p>
		 * 
		 * @return An <code>ICollectionIterator</code> pointing to the position of the last
		 * change or <code>null</code> if the event kind is <code>CollectionEvent.RESET</code>.
		 */
		public function iterator() : ICollectionIterator {
			// hook to be filled by concrete events
			return null;
		}

	}
}
