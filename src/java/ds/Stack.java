package ds;

import dto.Patient;

public class Stack {
    private Node top;
    private int size;

    public Stack() {
        top = null;
        size = 0;
    }

    public boolean isEmpty() {
        return top == null;
    }

    public int size() {
        return size;
    }

    // Đẩy vào stack
    public void push(Patient patient) {
        Node newNode = new Node(patient);
        newNode.next = top;
        top = newNode;
        size++;
    }

    // Lấy ra
    public Patient pop() {
        if (isEmpty()) return null;
        Patient data = top.data;
        top = top.next;
        size--;
        return data;
    }

    // Xem phần tử đỉnh
    public Patient peek() {
        if (isEmpty()) return null;
        return top.data;
    }

    // Lấy toàn bộ lịch sử (từ mới → cũ)
    public Patient[] toArray() {
        Patient[] arr = new Patient[size];
        Node current = top;
        int i = 0;
        while (current != null) {
            arr[i++] = current.data;
            current = current.next;
        }
        return arr;
    }

    public void clear() {
        top = null;
        size = 0;
    }
}