/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Window 11
 */
public class ScreenSize {
    private int screenID;
    private String size;

    public ScreenSize() {
    }

    public ScreenSize(int screenID, String size) {
        this.screenID = screenID;
        this.size = size;
    }

    public int getScreenID() {
        return screenID;
    }

    public void setScreenID(int screenID) {
        this.screenID = screenID;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

}

