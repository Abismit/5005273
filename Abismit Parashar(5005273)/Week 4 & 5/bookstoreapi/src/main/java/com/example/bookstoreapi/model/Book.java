package com.example.bookstoreapi.model;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class Book {
    private Long id;

    @NotBlank
    private String title;

    @NotBlank
    private String author;

    @Min(0)
    private double price;

    @NotNull
    private String isbn;
}
