package sist.movie;

public interface IReservation {

	boolean judgereserve(int seq, String id);
	int judgepoll(int seq, String id);
}
