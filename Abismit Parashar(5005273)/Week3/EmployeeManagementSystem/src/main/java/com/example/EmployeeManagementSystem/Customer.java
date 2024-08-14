@Entity
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToMany(mappedBy = "customer")
    @LazyCollection(LazyCollectionOption.EXTRA)
    private List<Order> orders;

    // Other fields, getters, setters...
}
