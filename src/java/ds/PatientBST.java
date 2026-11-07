package ds;

import dto.Patient;

public class PatientBST {
    private NodeTree root;
    private int size;

    public PatientBST() {
        root = null;
        size = 0;
    }

    public boolean isEmpty() {
        return root == null;
    }

    public int size() {
        return size;
    }

    // Thêm bệnh nhân vào BST
    public void insert(Patient patient) {
        root = insertRec(root, patient);
        size++;
    }

    private NodeTree insertRec(NodeTree node, Patient patient) {
        if (node == null) {
            return new NodeTree(patient);
        }

        int cmp = patient.getId().compareToIgnoreCase(node.data.getId());
        if (cmp < 0) {
            node.left = insertRec(node.left, patient);
        } else if (cmp > 0) {
            node.right = insertRec(node.right, patient);
        }
        // Nếu ID trùng thì không thêm
        return node;
    }

    // Tìm kiếm theo ID
    public Patient search(String id) {
        NodeTree result = searchRec(root, id);
        return (result != null) ? result.data : null;
    }

    private NodeTree searchRec(NodeTree node, String id) {
        if (node == null || node.data.getId().equalsIgnoreCase(id)) {
            return node;
        }

        if (id.compareToIgnoreCase(node.data.getId()) < 0) {
            return searchRec(node.left, id);
        } else {
            return searchRec(node.right, id);
        }
    }

    // Xóa theo ID
    public boolean delete(String id) {
        if (search(id) == null) return false;
        root = deleteRec(root, id);
        size--;
        return true;
    }

    private NodeTree deleteRec(NodeTree node, String id) {
        if (node == null) return null;

        int cmp = id.compareToIgnoreCase(node.data.getId());
        if (cmp < 0) {
            node.left = deleteRec(node.left, id);
        } else if (cmp > 0) {
            node.right = deleteRec(node.right, id);
        } else {
            // Node cần xóa
            if (node.left == null) return node.right;
            if (node.right == null) return node.left;

            // Có 2 con → lấy node nhỏ nhất bên phải
            NodeTree minNode = findMin(node.right);
            node.data = minNode.data;
            node.right = deleteRec(node.right, minNode.data.getId());
        }
        return node;
    }

    private NodeTree findMin(NodeTree node) {
        while (node.left != null) {
            node = node.left;
        }
        return node;
    }

    // Duyệt cây theo thứ tự tăng dần (In-order) để lấy danh sách
    public Patient[] toArray() {
        Patient[] arr = new Patient[size];
        inOrder(root, arr, new int[]{0});
        return arr;
    }

    private void inOrder(NodeTree node, Patient[] arr, int[] index) {
        if (node != null) {
            inOrder(node.left, arr, index);
            arr[index[0]++] = node.data;
            inOrder(node.right, arr, index);
        }
    }

    public void clear() {
        root = null;
        size = 0;
    }
}