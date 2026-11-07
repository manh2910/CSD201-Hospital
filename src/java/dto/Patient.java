package dto;

import java.io.Serializable;

public class Patient implements Serializable {
    private String id;          // Mã bệnh nhân (dùng làm key trong BST)
    private String name;        // Họ tên
    private int age;            // Tuổi
    private String gender;      // Nam / Nữ
    private String disease;     // Bệnh lý
    private String status;      // Trạng thái: Waiting, Admitted, Discharged
    private String phone;       // Số điện thoại

    public Patient() {
    }

    public Patient(String id, String name, int age, String gender, String disease, String status, String phone) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.disease = disease;
        this.status = status;
        this.phone = phone;
    }

    // Getter & Setter
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getDisease() {
        return disease;
    }

    public void setDisease(String disease) {
        this.disease = disease;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Patient{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", age=" + age +
                ", gender='" + gender + '\'' +
                ", disease='" + disease + '\'' +
                ", status='" + status + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}