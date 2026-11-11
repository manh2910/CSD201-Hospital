package service;

import dao.PatientDAO;
import ds.LinkedList;
import ds.PatientBST;
import ds.Queue;
import ds.Stack;
import dto.Patient;
import java.util.List;

public class HospitalService {

    private LinkedList admittedList;     // Bệnh nhân đang điều trị
    private Queue waitingQueue;          // Hàng chờ
    private PatientBST patientBST;       // Cây tìm kiếm
    private Stack historyStack;          // Lịch sử thao tác
    private PatientDAO patientDAO;       // Làm việc với Database

    public HospitalService() {
        admittedList = new LinkedList();
        waitingQueue = new Queue();
        patientBST = new PatientBST();
        historyStack = new Stack();
        patientDAO = new PatientDAO();

        // Load dữ liệu từ Database khi khởi tạo
        loadDataFromDatabase();
    }

    // ====================== LOAD DỮ LIỆU TỪ DATABASE ======================
    private void loadDataFromDatabase() {
        List<Patient> list = patientDAO.getAllPatients();

        for (Patient p : list) {
            // Thêm vào BST (tất cả bệnh nhân)
            patientBST.insert(p);

            if ("Waiting".equalsIgnoreCase(p.getStatus())) {
                waitingQueue.enqueue(p);
            } else if ("Admitted".equalsIgnoreCase(p.getStatus())) {
                admittedList.addLast(p);
            }
        }
        System.out.println(">>> Đã load " + list.size() + " bệnh nhân từ Database");
    }

    // ====================== THÊM BỆNH NHÂN VÀO HÀNG CHỜ ======================
    public boolean addToWaitingQueue(Patient patient) {
        if (patient == null || patient.getId() == null || patient.getId().trim().isEmpty()) {
            return false;
        }

        // Kiểm tra trùng ID
        if (patientBST.search(patient.getId()) != null) {
            return false;
        }

        patient.setStatus("Waiting");

        // 1. Lưu vào Database trước
        boolean saved = patientDAO.insert(patient);
        if (!saved) {
            return false;
        }

        // 2. Thêm vào cấu trúc dữ liệu trong bộ nhớ
        waitingQueue.enqueue(patient);
        patientBST.insert(patient);
        historyStack.push(copyPatient(patient));

        return true;
    }

    // ====================== GỌI BỆNH NHÂN TIẾP THEO ======================
    public Patient callNextPatient() {
        Patient patient = waitingQueue.dequeue();
        if (patient == null) return null;

        patient.setStatus("Admitted");

        // Cập nhật Database
        patientDAO.update(patient);

        // Cập nhật cấu trúc dữ liệu
        admittedList.addLast(patient);

        // Cập nhật BST
        patientBST.delete(patient.getId());
        patientBST.insert(patient);

        historyStack.push(copyPatient(patient));
        return patient;
    }

    // ====================== XUẤT VIỆN ======================
    public boolean dischargePatient(String id) {
        Patient patient = admittedList.findById(id);
        if (patient == null) return false;

        patient.setStatus("Discharged");

        // Cập nhật Database
        patientDAO.update(patient);

        // Xóa khỏi danh sách đang điều trị + BST
        admittedList.removeById(id);
        patientBST.delete(id);

        historyStack.push(copyPatient(patient));
        return true;
    }

    // ====================== TÌM KIẾM ======================
    public Patient searchById(String id) {
        // Ưu tiên tìm trong BST (nhanh)
        Patient p = patientBST.search(id);
        if (p != null) return p;

        // Nếu không có thì tìm xuống Database (dự phòng)
        return patientDAO.findById(id);
    }

    // ====================== CẬP NHẬT THÔNG TIN ======================
    public boolean updatePatient(Patient updated) {
        if (updated == null || updated.getId() == null) return false;

        boolean ok = patientDAO.update(updated);
        if (!ok) return false;

        // Cập nhật trong bộ nhớ
        patientBST.delete(updated.getId());
        patientBST.insert(updated);
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
        return patientBST.toArray();
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

    // ====================== UNDO ======================
    public Patient undoLastAction() {
        return historyStack.pop();
    }

    // ====================== CLEAR ======================
    public void clearAll() {
        admittedList.clear();
        waitingQueue.clear();
        patientBST.clear();
        historyStack.clear();
    }

    // Helper copy
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