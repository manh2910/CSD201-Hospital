package service;

import ds.LinkedList;
import ds.PatientBST;
import ds.Queue;
import ds.Stack;
import dto.Patient;

public class HospitalService {

    // Các cấu trúc dữ liệu chính
    private LinkedList admittedList;     // Danh sách bệnh nhân đã nhập viện
    private Queue waitingQueue;          // Hàng chờ khám
    private PatientBST patientBST;       // Cây tìm kiếm theo ID
    private Stack historyStack;          // Lịch sử thao tác (để Undo)

    public HospitalService() {
        admittedList = new LinkedList();
        waitingQueue = new Queue();
        patientBST = new PatientBST();
        historyStack = new Stack();
    }

    // ====================== THÊM BỆNH NHÂN VÀO HÀNG CHỜ ======================
    public boolean addToWaitingQueue(Patient patient) {
        if (patient == null || patient.getId() == null || patient.getId().trim().isEmpty()) {
            return false;
        }

        // Kiểm tra trùng ID trong BST
        if (patientBST.search(patient.getId()) != null) {
            return false; // Đã tồn tại
        }

        // Kiểm tra trùng trong hàng chờ
        if (waitingQueue.contains(patient.getId())) {
            return false;
        }

        patient.setStatus("Waiting");
        waitingQueue.enqueue(patient);
        patientBST.insert(patient);

        // Lưu lịch sử
        historyStack.push(copyPatient(patient));

        return true;
    }

    // ====================== CHO BỆNH NHÂN VÀO KHÁM (DEQUEUE) ======================
    public Patient callNextPatient() {
        Patient patient = waitingQueue.dequeue();
        if (patient != null) {
            patient.setStatus("Admitted");
            admittedList.addLast(patient);

            // Cập nhật lại trong BST
            patientBST.delete(patient.getId());
            patientBST.insert(patient);

            historyStack.push(copyPatient(patient));
        }
        return patient;
    }

    // ====================== XUẤT VIỆN ======================
    public boolean dischargePatient(String id) {
        Patient patient = admittedList.findById(id);
        if (patient == null) return false;

        patient.setStatus("Discharged");
        admittedList.removeById(id);
        patientBST.delete(id);

        historyStack.push(copyPatient(patient));
        return true;
    }

    // ====================== TÌM KIẾM THEO ID ======================
    public Patient searchById(String id) {
        return patientBST.search(id);
    }

    // ====================== CẬP NHẬT THÔNG TIN ======================
    public boolean updatePatient(Patient updated) {
        if (updated == null || updated.getId() == null) return false;

        Patient existing = patientBST.search(updated.getId());
        if (existing == null) return false;

        // Cập nhật trong BST
        patientBST.delete(updated.getId());
        patientBST.insert(updated);

        // Cập nhật trong LinkedList nếu đang nằm viện
        admittedList.update(updated);

        historyStack.push(copyPatient(updated));
        return true;
    }

    // ====================== LẤY DANH SÁCH ======================
    public Patient[] getWaitingList() {
        return waitingQueue.toArray();
    }

    public Patient[] getAdmittedList() {
        return admittedList.toArray();
    }

    public Patient[] getAllPatientsSorted() {
        return patientBST.toArray(); // Đã sắp xếp theo ID
    }

    public Patient[] getHistory() {
        return historyStack.toArray();
    }

    // ====================== THỐNG KÊ ======================
    public int getWaitingCount() {
        return waitingQueue.size();
    }

    public int getAdmittedCount() {
        return admittedList.size();
    }

    public int getTotalPatients() {
        return patientBST.size();
    }

    // ====================== UNDO (Lấy thao tác gần nhất) ======================
    public Patient undoLastAction() {
        return historyStack.pop();
    }

    // ====================== CLEAR TOÀN BỘ ======================
    public void clearAll() {
        admittedList.clear();
        waitingQueue.clear();
        patientBST.clear();
        historyStack.clear();
    }

    // Helper: copy object để lưu lịch sử
    private Patient copyPatient(Patient p) {
        return new Patient(
                p.getId(),
                p.getName(),
                p.getAge(),
                p.getGender(),
                p.getDisease(),
                p.getStatus(),
                p.getPhone()
        );
    }
}