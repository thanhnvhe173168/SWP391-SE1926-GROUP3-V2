/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author Window 11
 */

public class Laptop {

    private int laptopID;
    private String laptopName;
    private BigDecimal price;
    private int stock;
    private String description;
    private String imageURL;
    private String hardDrive;
    private Status status;
    private String warrantyPeriod;
    private CPU cpu;
    private ScreenSize screen;
    private String ram;
    private Brand brand;
    private Category category;

    // Constructors
    public Laptop() {
    }

    public Laptop(int laptopID, String laptopName, BigDecimal price, int stock, String description,
            String imageURL, String hardDrive, Status status, String warrantyPeriod,
            CPU cpu, ScreenSize screen, String ram, Brand brand, Category category) {
        this.laptopID = laptopID;
        this.laptopName = laptopName;
        this.price = price;
        this.stock = stock;
        this.description = description;
        this.imageURL = imageURL;
        this.hardDrive = hardDrive;
        this.status = status;
        this.warrantyPeriod = warrantyPeriod;
        this.cpu = cpu;
        this.screen = screen;
        this.ram = ram;
        this.brand = brand;
        this.category = category;
    }

    public Laptop(int laptopID, String laptopName, BigDecimal price, int stock, String description, String hardDrive, String warrantyPeriod) {
        this.laptopID = laptopID;
        this.laptopName = laptopName;
        this.price = price;
        this.stock = stock;
        this.description = description;
        this.hardDrive = hardDrive;
        this.warrantyPeriod = warrantyPeriod;
    }

    // Getters and Setters
    public int getLaptopID() {
        return laptopID;
    }

    public void setLaptopID(int laptopID) {
        this.laptopID = laptopID;
    }

    public String getLaptopName() {
        return laptopName;
    }

    public void setLaptopName(String laptopName) {
        this.laptopName = laptopName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getHardDrive() {
        return hardDrive;
    }

    public void setHardDrive(String hardDrive) {
        this.hardDrive = hardDrive;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatusID(Status status) {
        this.status = status;
    }

    public String getWarrantyPeriod() {
        return warrantyPeriod;
    }

    public void setWarrantyPeriod(String warrantyPeriod) {
        this.warrantyPeriod = warrantyPeriod;
    }

    public CPU getCpu() {
        return cpu;
    }

    public void setCpu(CPU cpu) {
        this.cpu = cpu;
    }

    public ScreenSize getScreen() {
        return screen;
    }

    public void setScreen(ScreenSize screen) {
        this.screen = screen;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

}
