package com.xlab;

import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;

public class Main {
    private static final String TIP_PATH = "README.txt";

    public static void main(String[] args) {
        tips();
        try {
            List<VisitorConfig> configs = VisitorConfig.createConfiges(FileParser.parseConfig());
            for (final VisitorConfig vc : configs) {
                new Thread() {
                    @Override
                    public void run() {
                        try {
                            new Main().visit(vc);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }.start();
            }
            new Timer().schedule(new TimerTask() {
                public void run() {
                    try {
                        CmdProxy.getInstance().closeWeb();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }, configs.get(0).getCloseWebInterval(), configs.get(0).getCloseWebInterval());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void tips() {
        FileParser.read(TIP_PATH).stream().forEach(str -> System.out.println(str));
    }

    private void visit(VisitorConfig vc) throws IOException, InterruptedException {
        for (int i = 1; i <= vc.getNum(); i++) {
            CmdProxy.getInstance().openWeb(vc.getUrl());
            int interval = new Random().nextInt(vc.getInterval());
            Thread.sleep(interval == 0 ? vc.getInterval() : interval);
        }
    }
}