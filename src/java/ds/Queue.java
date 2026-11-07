package ds;

import dto.Patient;

public class Queue {
    private Node front;
    private Node rear;
    private int size;

    public Queue() {
        front = null;
        rear = null;
        size = 0;
    }

    public boolean isEmpty() {
        return front == null;
    }

    public int size() {
        return size;
    }

    // Thêm vào cuối hàng chờ (enqueue)
    public void enqueue(Patient patient) {
        Node newNode = new Node(patient);
        if (isEmpty()) {
            front = rear = newNode;
        } else {
            rear.next = newNode;
            rear = newNode;
        }
        size++;
    }

    // Lấy bệnh nhân đầu hàng ra khám (dequeue)
    public Patient dequeue() {
        if (isEmpty()) return null;

        Patient data = front.data;
        front = front.next;
        if (front == null) rear = null;
        size--;
        return data;
    }

    // Xem bệnh nhân đầu hàng (không xóa)
    public Patient peek() {
        if (isEmpty()) return null;
        return front.data;
    }

    // Kiểm tra bệnh nhân đã có trong hàng chờ chưa
    public boolean contains(String id) {
        Node current = front;
        while (current != null) {
            if (current.data.getId().equalsIgnoreCase(id)) {
                return true;
            }
            current = current.next;
        }
        return false;
    }

    // Lấy toàn bộ hàng chờ
    public Patient[] toArray() {
        Patient[] arr = new Patient[size];
        Node current = front;
        int i = 0;
        while (current != null) {
            arr[i++] = current.data;
            current = current.next;
        }
        return arr;
    }

    public void clear() {
        front = rear = null;
        size = 0;
    }
}