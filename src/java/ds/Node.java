package ds;

import dto.Patient;

public class Node {
    public Patient data;
    public Node next;

    public Node(Patient data) {
        this.data = data;
        this.next = null;
    }

    public Node(Patient data, Node next) {
        this.data = data;
        this.next = next;
    }
}