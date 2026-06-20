package com.xlab;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileParser {
    public static final String CONFIG_V1 = "config.txt";
    public static final String CONFIG_V2 = "config.json";

    public static List<String> readConfig() {
        return read(CONFIG_V1);
    }

    public static List<String> read(String path) {
        File file = new File(path);
        List<String> content = new ArrayList<>();
        try (BufferedReader bufferedReader =
                     new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"))) {
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                content.add(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return content;
    }

    public static String parseConfig() {
        String fileName = CONFIG_V2;
        File jsonFile = new File(fileName);
        try (Reader reader = new InputStreamReader(new FileInputStream(jsonFile), "utf-8")) {
            int ch = 0;
            StringBuffer sb = new StringBuffer();
            while ((ch = reader.read()) != -1) {
                sb.append((char) ch);
            }
            return sb.toString();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
