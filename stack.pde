class Stack<T> {
    int size;
    Node top;

    Stack() {
        this.size = 0;
        this.top = null;
    }

    void push(T value) {
        Node newNode = new Node(value);
        newNode.next = this.top;
        this.top = newNode;
        this.size++;
    }

    T pop() {
        if (this.top == null) {
            return null;
        }
        T value = this.top.value;
        this.top = this.top.next;
        this.size--;
        return value;
    }

    T peek() {
        if (this.top == null) {
            return null;
        }
        return this.top.value;
    }

    class Node {
        Node next;
        T value;
        Node (T value) {
            this.value = value;
        }
    }
}
