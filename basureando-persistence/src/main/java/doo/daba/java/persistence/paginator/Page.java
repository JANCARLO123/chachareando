package doo.daba.java.persistence.paginator;

import lombok.*;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Gerardo Aquino
 * Date: 4/07/13
 */
@NoArgsConstructor
@RequiredArgsConstructor
public class Page<T> {

    @NonNull
    @Getter @Setter
    private int
            currentPage,
            itemsPerPage;
    ;



    @Getter @Setter
    private int
            totalRecords,
            totalPages
            ;



    @Getter @Setter
    private List<T> items;


	public boolean isEmpty() {
		return this.items == null ||this.items.isEmpty();
	}

}
