abstract class OnHttpListener<T> {
  void onHttpError(Exception e);

  void onHttpFinish(T bean);
}
