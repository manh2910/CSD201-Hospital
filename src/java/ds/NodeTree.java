package ds;

import dto.Patient;

public class NodeTree {
    public Patient data;
    public NodeTree left;
    public NodeTree right;

    public NodeTree(Patient data) {
        this.data = data;
        this.left = null;
        this.right = null;
    }
}