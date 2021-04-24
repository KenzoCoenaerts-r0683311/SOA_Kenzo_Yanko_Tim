package be.soa.account;

import org.springframework.data.jpa.repository.JpaRepository;

public interface RestaurantRepository extends JpaRepository<Account, Long> {
    Account findAccountById(long id);
}
