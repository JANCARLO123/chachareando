package doo.daba.java.persistence;

import doo.daba.java.persistence.paginator.Page;
import doo.daba.java.persistence.persitenceMapping.ObjectMapping;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: java_daba_doo
 * Date: 7/5/13
 */
public class PersistenceHelper {

	public static <T> Page<T> resolveQueries(
			final String dataQuery,
	        final String countQuery,
	        final JdbcTemplate jdbcTemplate,
	        final ObjectMapping<T> rowMapper,
	        final Object[] dataQueryParams,
	        final Object[] countQueryParams
	) {

		int paginationSize = Integer.parseInt(dataQueryParams[dataQueryParams.length - 2].toString());
		int currentPage = Integer.parseInt(dataQueryParams[dataQueryParams.length - 1].toString());

		Page<T> userEntriesPage = new Page<T>(currentPage, paginationSize);
		List<T> items = null;
		int totalPages = 0;

		int totalItems = jdbcTemplate.queryForObject(
				countQuery,
				Integer.class,
				countQueryParams);

		if(totalItems > 0){
			items = jdbcTemplate.query(
					dataQuery,
					rowMapper,
					paginationSize,
					paginationSize * currentPage);

			totalPages = totalItems / paginationSize;
			if(totalItems % paginationSize != 0){
				totalItems++;
			}
		}

		userEntriesPage.setItems(items);
		userEntriesPage.setTotalRecords(totalItems);
		userEntriesPage.setTotalPages(totalPages);

		return userEntriesPage;
	}

}
