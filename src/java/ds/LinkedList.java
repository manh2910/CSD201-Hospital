package ds;

import dto.Patient;

public class LinkedList {
    private Node head;
    private Node tail;
    private int size;

    public LinkedList() {
        head = null;
        tail = null;
        size = 0;
    }

    public boolean isEmpty() {
        return head == null;
    }

    public int size() {
        return size;
    }

    // Thêm vào cuối danh sách
    public void addLast(Patient patient) {
        Node newNode = new Node(patient);
        if (isEmpty()) {
            head = tail = newNode;
        } else {
            tail.next = newNode;
            tail = newNode;
        }
        size++;
    }

    // Thêm vào đầu danh sách
    public void addFirst(Patient patient) {
        Node newNode = new Node(patient);
        if (isEmpty()) {
            head = tail = newNode;
        } else {
            newNode.next = head;
            head = newNode;
        }
        size++;
    }

    // Xóa theo ID
    public boolean removeById(String id) {
        if (isEmpty()) return false;

        // Xóa node đầu
        if (head.data.getId().equalsIgnoreCase(id)) {
            head = head.next;
            if (head == null) tail = null;
            size--;
            return true;
        }

        Node current = head;
        while (current.next != null) {
            if (current.next.data.getId().equalsIgnoreCase(id)) {
                current.next = current.next.next;
                if (current.next == null) tail = current;
                size--;
                return true;
            }
            current = current.next;
        }
        return false;
    }

    // Tìm theo ID
    public Patient findById(String id) {
        Node current = head;
        while (current != null) {
            if (current.data.getId().equalsIgnoreCase(id)) {
                return current.data;
            }
            current = current.next;
        }
        return null;
    }

    // Cập nhật thông tin bệnh nhân
    public boolean update(Patient updatedPatient) {
        Node current = head;
        while (current != null) {
            if (current.data.getId().equalsIgnoreCase(updatedPatient.getId())) {
                current.data = updatedPatient;
                return true;
            }
            current = current.next;
        }
        return false;
    }

    // Lấy toàn bộ danh sách (trả về mảng)
    public Patient[] toArray() {
        Patient[] arr = new Patient[size];
        Node current = head;
        int i = 0;
        while (current != null) {
            arr[i++] = current.data;
            current = current.next;
        }
        return arr;
    }

    // Xóa toàn bộ
    public void clear() {
        head = tail = null;
        size = 0;
    }
}