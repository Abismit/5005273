@Entity
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany(mappedBy = "order")
    @BatchSize(size = 10) // Fetch 10 products at a time
    private List<Product> products;

    // Other fields, getters, setters...
}
