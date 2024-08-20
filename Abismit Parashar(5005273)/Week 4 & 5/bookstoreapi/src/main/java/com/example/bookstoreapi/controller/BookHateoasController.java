package com.example.bookstoreapi.controller;

import com.example.bookstoreapi.model.Book;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.mvc.WebMvcLinkBuilder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BookHateoasController {

    @GetMapping("/books/{id}/hateoas")
    public EntityModel<Book> getBookById(@PathVariable Long id) {
        Book book = new Book(); // Assume you fetch the book by id

        EntityModel<Book> resource = EntityModel.of(book);
        resource.add(WebMvcLinkBuilder.linkTo(WebMvcLinkBuilder.methodOn(BookController.class).getAllBooks()).withRel("books"));
        return resource;
    }
}
