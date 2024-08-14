import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.yourcompany.employeemanagementsystem.model.Department;

@Repository
public interface DepartmentRepository extends JpaRepository<Department, Long> {
    // You can define custom query methods here if needed
    // For example: Optional<Department> findByName(String name);
}
