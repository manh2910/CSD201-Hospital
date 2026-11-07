package fileio;

import dto.Patient;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PatientFileIO {

    private static final String FILE_PATH = "patients.txt";

    // Lưu danh sách bệnh nhân ra file
    public static void saveToFile(Patient[] patients) {
        try (PrintWriter writer = new PrintWriter(new FileWriter(FILE_PATH))) {
            for (Patient p : patients) {
                if (p != null) {
                    writer.println(p.getId() + "|" +
                            p.getName() + "|" +
                            p.getAge() + "|" +
                            p.getGender() + "|" +
                            p.getDisease() + "|" +
                            p.getStatus() + "|" +
                            p.getPhone());
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Đọc danh sách bệnh nhân từ file
    public static List<Patient> loadFromFile() {
        List<Patient> list = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return list;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 7) {
                    Patient p = new Patient(
                            parts[0],
                            parts[1],
                            Integer.parseInt(parts[2]),
                            parts[3],
                            parts[4],
                            parts[5],
                            parts[6]
                    );
                    list.add(p);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }
}