# README

## 목차

공공 데이터를 활용하여 전국 여행지 정보를 제공하는 사이트

1. **기능**
    - 정보 게시판
        - 글 목록 조회
        - 글쓰기/수정/삭제 기능 (로그인 시에만)
    - 로그인, 로그아웃
        - 로그인 시
            - 회원 이름을 포함한 문구 표시
            - 정보 게시판에서 글 작성 가능
            - 해당 아이디로 쓴 글에 한에 수정 및 삭제 가능
    - 전국의 시도/구군/동 별 아파트 매매 정보를 년도 월 별 테이블과 카카오 맵을 통한 정보 제공 기능
        - DB를 통한 비동기 요청 방식
2. **Class Diagram & ERD**

---

# ✅ 1. 메인 화면 페이지

## 👀 1.1 실행 화면

### 1.1.1 메인 화면

![메인1.png](README%204ad9456f389843ad81d58f4ddc44157a/%25EB%25A9%2594%25EC%259D%25B81.png)

### 1.1.2 지역별 관광지바 Slide down

![메인페이지_지역별관광지.png](README%204ad9456f389843ad81d58f4ddc44157a/%25EB%25A9%2594%25EC%259D%25B8%25ED%258E%2598%25EC%259D%25B4%25EC%25A7%2580_%25EC%25A7%2580%25EC%2597%25AD%25EB%25B3%2584%25EA%25B4%2580%25EA%25B4%2591%25EC%25A7%2580.png)

### 1.1.3 테마바 Slide down

![메인페이지_테마.png](README%204ad9456f389843ad81d58f4ddc44157a/%25EB%25A9%2594%25EC%259D%25B8%25ED%258E%2598%25EC%259D%25B4%25EC%25A7%2580_%25ED%2585%258C%25EB%25A7%2588.png)

### 1.1.4 정보 게시판바 Slide down

![메인페이지_게시판.png](README%204ad9456f389843ad81d58f4ddc44157a/%25EB%25A9%2594%25EC%259D%25B8%25ED%258E%2598%25EC%259D%25B4%25EC%25A7%2580_%25EA%25B2%258C%25EC%258B%259C%25ED%258C%2590.png)

## 1.2 💻 메인 화면 code

- <details>
  public class AttractionDaoImpl implements AttractionDao {
    
    ```
    static private AttractionDao attractionDao = new AttractionDaoImpl();
        static private DBUtil dbUtil = DBUtil.getInstance();
    
        private AttractionDaoImpl() {}
    
        public static AttractionDao getAttractionDao() {
            return attractionDao;
        }
    
        @Override
        public List<AttractionInfoDto> attractionList(AttractionInfoDto conditionDto) throws SQLException {
            List<AttractionInfoDto> list = new ArrayList<AttractionInfoDto>();
    
            String sql = "select *\r\n" +
                    "from attraction_info\r\n" +
                    "where content_type_id = ? and sido_code = ?;";
    
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = dbUtil.getConnection();
    
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, conditionDto.getContentTypeId());
                pstmt.setInt(2, conditionDto.getSidoCode());
                rs = pstmt.executeQuery();
    
                while(rs.next()) {
                    int contentId = rs.getInt("content_id");
                    int contentTypeId = rs.getInt("content_type_id");
                    String title = rs.getString("title");
                    String addr1 = rs.getString("addr1");
                    String addr2 = rs.getString("addr2");
                    String zipcode = rs.getString("zipcode");
                    String tel = rs.getString("tel");
                    String firstImage = rs.getString("first_image");
                    String firstImage2 = rs.getString("first_image2");
                    int readcount = rs.getInt("readcount");
                    int sidoCode = rs.getInt("sido_code");
                    int gugunCode = rs.getInt("gugun_code");
                    double latitude = rs.getDouble("latitude");
                    double longitude = rs.getDouble("longitude");
                    String mlevel = rs.getString("mlevel");
    
                    AttractionInfoDto attractionInfoDto = new AttractionInfoDto(contentId, contentTypeId, title, addr1, addr2, zipcode, tel, firstImage, firstImage2, readcount, sidoCode, gugunCode, latitude, longitude, mlevel);
                    list.add(attractionInfoDto);
                }
            } finally {
                dbUtil.close(rs, pstmt, conn);
            }
    
            return list;
        }
    
        @Override
        public List<AttractionInfoDto> searchByTitle(String titleInput, int sidoCodeInput) throws SQLException {
            List<AttractionInfoDto> list = new ArrayList<AttractionInfoDto>();
    
            String sql = "select *\r\n" +
                    "from attraction_info\r\n" +
                    "where title like ? and sido_code = ?;";
    
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = dbUtil.getConnection();
    
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%"+titleInput+"%");
                pstmt.setInt(2, sidoCodeInput);
                rs = pstmt.executeQuery();
    
                while(rs.next()) {
                    int contentId = rs.getInt("content_id");
                    int contentTypeId = rs.getInt("content_type_id");
                    String title = rs.getString("title");
                    String addr1 = rs.getString("addr1");
                    String addr2 = rs.getString("addr2");
                    String zipcode = rs.getString("zipcode");
                    String tel = rs.getString("tel");
                    String firstImage = rs.getString("first_image");
                    String firstImage2 = rs.getString("first_image2");
                    int readcount = rs.getInt("readcount");
                    int sidoCode = rs.getInt("sido_code");
                    int gugunCode = rs.getInt("gugun_code");
                    double latitude = rs.getDouble("latitude");
                    double longitude = rs.getDouble("longitude");
                    String mlevel = rs.getString("mlevel");
    
                    AttractionInfoDto attractionInfoDto = new AttractionInfoDto(contentId, contentTypeId, title, addr1, addr2, zipcode, tel, firstImage, firstImage2, readcount, sidoCode, gugunCode, latitude, longitude, mlevel);
                    list.add(attractionInfoDto);
                }
            } finally {
                dbUtil.close(rs, pstmt, conn);
            }
    
            return list;
        }
    
    }
    ```
  </details>
    
    
    

# ✅ 2. 로그인 기능

## 👀 2.1. 실행화면

### 2.1.1 회원가입

![Animation2.gif](README%204ad9456f389843ad81d58f4ddc44157a/Animation2.gif)

### 2.1.2 로그인

![Animation3.gif](README%204ad9456f389843ad81d58f4ddc44157a/Animation3.gif)

## 2.2. 💻 code

<details>
<summary>코드 펼치기</summary>

  Memeber DB대신 사용되는 DTO 객체
---
    ```
    public class MemberDto {
	private String userId;
	private String userName;
	private String userPassword;
		
	public MemberDto() {
		super();
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	@Override
	public String toString() {
		return "MemberDto [userId=" + userId + ", user_name=" + userName + ", userPassword=" + userPassword + "]";
	}
    ```
   
   
   실질적인 로직처리를 하는 DAO
   ---
   ```
    public class BoardDaoImpl implements BoardDao {
	private DBUtil dbUtil=DBUtil.getInstance();
	
	@Override
	public List<BoardDto> selectAll() throws SQLException {
		List<BoardDto> list=new ArrayList<>();
		String sql="select * from board;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDto boardDto=new BoardDto();
				boardDto.setArticleNo(rs.getInt("article_no"));
				boardDto.setUserId(rs.getString("user_id"));
				boardDto.setSubject(rs.getString("subject"));
				boardDto.setContent(rs.getString("content"));
				boardDto.setRegisterTime(rs.getString("register_time"));
				
				list.add(boardDto);
			}
			
			return list;
		} finally {
			dbUtil.close(conn,pstmt,rs);
		}
		
	}

	@Override
	public BoardDto selectByArticleNo(int articleNo) throws SQLException {
		BoardDto boardDto=new BoardDto();
		String sql="select * from board where article_no=?;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, articleNo);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				boardDto.setArticleNo(rs.getInt("article_no"));
				boardDto.setUserId(rs.getString("user_id"));
				boardDto.setSubject(rs.getString("subject"));
				boardDto.setContent(rs.getString("content"));
				boardDto.setRegisterTime(rs.getString("register_time"));
				
				return boardDto;
			}
			
			return null;
		} finally {
			dbUtil.close(conn,pstmt,rs);
		}
	}

	@Override
	public void deleteByArticleNo(int articleNo) throws SQLException {
		
		String sql="delete from board where article_no=?;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, articleNo);
			
			int cnt= pstmt.executeUpdate();
			
			
		} finally {
			dbUtil.close(conn,pstmt);
		}
		
	}

	@Override
	public void regist(BoardDto boardDto) throws SQLException {
		String sql="insert into board (user_id, subject, content)\r\n" + 
				"value(?, ?, ?);";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, boardDto.getUserId());
			pstmt.setString(2, boardDto.getSubject() );
			pstmt.setString(3, boardDto.getContent());
			
			int cnt= pstmt.executeUpdate();
			
			
		} finally {
			dbUtil.close(conn,pstmt);
		}
	}

	@Override
	public void modify(BoardDto boardDto) throws SQLException {
		String sql="update board\r\n" + 
				"set subject=?, content=?\r\n" + 
				"where user_id=?;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, boardDto.getSubject());
			pstmt.setString(2, boardDto.getContent());
			pstmt.setString(3, boardDto.getUserId());
			
			int cnt= pstmt.executeUpdate();
			
			
		} finally {
			dbUtil.close(conn,pstmt);
		}	
	}
}
```

Controller의 요청을 DAO으로 전달하는 Service
---
```
public class MemberServiceImpl implements MemberService {
	private MemberDao memberDao=new MemberDaoImpl();
	@Override
	public MemberDto login(String userId, String userPassword) throws SQLException {
		return memberDao.login(userId, userPassword);
	}
	@Override
	public void join(MemberDto memberDto) throws SQLException {
		memberDao.join(memberDto);
		
	}
```

요청 처리 제어를 담당하는 Controller
---
```
@WebServlet("/member")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MemberService memberService=new MemberServiceImpl();
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action=request.getParameter("action");
		
		switch (action) {
		case "mvlogin":
			response.sendRedirect(request.getContextPath()+"/login.jsp");
			break;
		case "login":
			login(request,response);
			break;
		case "mvjoin":
			response.sendRedirect(request.getContextPath()+"/join.jsp");
			break;
		case "join":
			join(request,response);
			break;
		case "logout":
			logout(request,response);
			break;

		default:
			break;
		}
		
	}

	
	private void join(HttpServletRequest request, HttpServletResponse response) throws IOException {
		MemberDto memberDto=new MemberDto();
		System.out.println("회원가입 시작");
		String userId=request.getParameter("userId");
		String userName=request.getParameter("userName");
		String userPassword=request.getParameter("userPassword");
		
		memberDto.setUserId(userId);
		memberDto.setUserName(userName);
		memberDto.setUserPassword(userPassword);
		
		try {
			memberService.join(memberDto);
			System.out.println("회원가입 성공");
			response.sendRedirect(request.getContextPath()+"/index.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}


	private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("로그아웃 시작");
		HttpSession session=request.getSession();
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	}


	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("로그인 시작");
		String userId=request.getParameter("userId");
		String userPassword=request.getParameter("userPassword");
		
		
		try {
			MemberDto memberInfo=memberService.login(userId, userPassword);
			
			
			if(memberInfo!=null) {
				System.out.println("로그인 성공 : "+ memberInfo);
				HttpSession session=request.getSession();
				session.setAttribute("memberInfo", memberInfo);
				
				//====================쿠키 설정=======================
				String idsave = request.getParameter("saveid");
				if("ok".equals(idsave)) { //아이디 저장을 체크 했다면.
					Cookie cookie = new Cookie("ssafy_id", userId);
					cookie.setPath(request.getContextPath());
//					크롬의 경우 400일이 최대
//					https://developer.chrome.com/blog/cookie-max-age-expires/
					cookie.setMaxAge(60 * 60 * 24 * 365 * 40); //40년간 저장.
					response.addCookie(cookie);
				} else { //아이디 저장을 해제 했다면.
					Cookie cookies[] = request.getCookies();
					if(cookies != null) {
						for(Cookie cookie : cookies) {
							if("ssafy_id".equals(cookie.getName())) {
								cookie.setMaxAge(0);
								response.addCookie(cookie);
								break;
							}
						}
					}
				}
				//====================쿠키 설정=======================
				
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else {
				System.out.println("로그인 실패");
				request.setAttribute("msg", "아이디 또는 비밀번호 확인 후 다시 로그인하세요.");
				request.getRequestDispatcher("/login.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
//			request.setAttribute("msg", "로그인 중 에러 발생!!!");
//			return "/error/error.jsp";
		}
		
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
```
회원가입 화면 JSP
---
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="icon" href="./assets/images/favicon.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/icon?family=Material+Icons"
    />
    <!-- Latest compiled and minified CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
    />

    <!-- Latest compiled JavaScript -->
    <script
      defer
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
    ></script>

    <link
      href="
https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css
"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="./assets/css/main.css" />
    <link rel="stylesheet" href="./assets/css/signin.css">
    <script defer src="./assets/js/main.js"></script>
</head>
<body>


    <!-- 헤더 -->

    <%@ include file="/include/header.jsp" %>
      <!-- 상단 navbar end -->

    <section class="signin">
        <h1>회원 가입</h1>
        <div class="signin__card">
          <h2>
            <strong>Welcome!</strong> 회원가입을 시작합니다.
          </h2>
          <form action="${pageContext.request.contextPath}/member?action=join" method="POST">
          	<input type="text" placeholder="사용자 이름을 입력하세요." name="userName"/>
            <input type="text" placeholder="아이디를 입력하세요." name="userId"/>
            <input type="password" placeholder="비밀번호를 입력하세요." name="userPassword"/>
            <input type="submit" value="회원가입" />
            <p>
              * 비밀번호는 6자리 이상으로 설정해주세요!
            </p>
          </form>
          <div class="actions">
            <a href="${pageContext.request.contextPath}/member?action=mvlogin">로그인</a>
            <a href="javascript:void(0)">아이디 찾기</a>
            <a href="javascript:void(0)">비밀번호 찾기</a>
          </div>
        </div>
      </section>

      <%@ include file="/include/footer.jsp" %>
</body>
</html>
```
로그인 화면 JSP
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="icon" href="./assets/images/favicon.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://fonts.googleapis.com/icon?family=Material+Icons"
    />
    <!-- Latest compiled and minified CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
    />

    <!-- Latest compiled JavaScript -->
    <script
      defer
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
    ></script>

    <link
      href="
https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css
"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="./assets/css/main.css" />
    <link rel="stylesheet" href="./assets/css/signin.css">
    <script defer src="./assets/js/main.js"></script>
</head>
<body>


    <!-- 헤더 -->

    <%@ include file="/include/header.jsp" %>
      <!-- 상단 navbar end -->

    <section class="signin">
        <h1>Login</h1>
        <div class="signin__card">
          <h2>
            <strong>Welcome!</strong> Enjoy Trip에 오신 것을 환영합니다.
          </h2>
          <form action="${pageContext.request.contextPath}/member?action=login" method="POST">
            <input type="text" placeholder="아이디를 입력하세요." name="userId"/>
            <input type="password" placeholder="비밀번호를 입력하세요." name="userPassword"/>
            <input type="submit" value="로그인" />
            <p>
              * 비밀번호를 타 사이트와 같이 사용할 경우 도용 위험이 있으니, <br />
              정기적으로 비밀번호를 변경하세요!
            </p>
          </form>
          <div class="actions">
            <a href="${pageContext.request.contextPath}/member?action=mvjoin">회원가입</a>
            <a href="javascript:void(0)">아이디 찾기</a>
            <a href="javascript:void(0)">비밀번호 찾기</a>
          </div>
        </div>
      </section>

      <%@ include file="/include/footer.jsp" %>
</body>
</html>
```
</details>
    

# ✅ 3. 게시판 관리

## 👀 3.1. 실행화면

### 3.1.1. 게시판 이동

![Animation4.gif](README%204ad9456f389843ad81d58f4ddc44157a/Animation4.gif)

### 3.1.2. 글 목록

![게시판.png](README%204ad9456f389843ad81d58f4ddc44157a/%25EA%25B2%258C%25EC%258B%259C%25ED%258C%2590.png)

### 3.1.3. 글 쓰기 (초기화 기능 포함)

![Animation5.gif](README%204ad9456f389843ad81d58f4ddc44157a/Animation5.gif)

### 3.1.4. 글 보기

![게시판글.png](README%204ad9456f389843ad81d58f4ddc44157a/%25EA%25B2%258C%25EC%258B%259C%25ED%258C%2590%25EA%25B8%2580.png)

### 3.1.5. 글 수정

![Animation6.gif](README%204ad9456f389843ad81d58f4ddc44157a/Animation6.gif)

### 3.1.6. 글 삭제

## 3.2.  code

<details>
<summary>코드 펼치기</summary>

Board DB대신 사용되는 DTO 객체
---
```
	public class BoardDto {
	private int articleNo;
	private String userId;
	private String subject;
	private String content;
	private String registerTime;
	
	
	public BoardDto() {
	}


	public int getArticleNo() {
		return articleNo;
	}


	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getSubject() {
		return subject;
	}


	public void setSubject(String subject) {
		this.subject = subject;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getRegisterTime() {
		return registerTime;
	}


	public void setRegisterTime(String registerTime) {
		this.registerTime = registerTime;
	}


	@Override
	public String toString() {
		return "BoardDto [articleNo=" + articleNo + ", userId=" + userId + ", subject=" + subject + ", content="
				+ content + ", registerTime=" + registerTime + "]";
	}	
}
```
실질적인 로직 처리를 하는 DAO
---
```
public class BoardDaoImpl implements BoardDao {
	private DBUtil dbUtil=DBUtil.getInstance();
	
	@Override
	public List<BoardDto> selectAll() throws SQLException {
		List<BoardDto> list=new ArrayList<>();
		String sql="select * from board;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDto boardDto=new BoardDto();
				boardDto.setArticleNo(rs.getInt("article_no"));
				boardDto.setUserId(rs.getString("user_id"));
				boardDto.setSubject(rs.getString("subject"));
				boardDto.setContent(rs.getString("content"));
				boardDto.setRegisterTime(rs.getString("register_time"));
				
				list.add(boardDto);
			}
			
			return list;
		} finally {
			dbUtil.close(conn,pstmt,rs);
		}
		
	}

	@Override
	public BoardDto selectByArticleNo(int articleNo) throws SQLException {
		BoardDto boardDto=new BoardDto();
		String sql="select * from board where article_no=?;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, articleNo);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				boardDto.setArticleNo(rs.getInt("article_no"));
				boardDto.setUserId(rs.getString("user_id"));
				boardDto.setSubject(rs.getString("subject"));
				boardDto.setContent(rs.getString("content"));
				boardDto.setRegisterTime(rs.getString("register_time"));
				
				return boardDto;
			}
			
			return null;
		} finally {
			dbUtil.close(conn,pstmt,rs);
		}
	}

	@Override
	public void deleteByArticleNo(int articleNo) throws SQLException {
		
		String sql="delete from board where article_no=?;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, articleNo);
			
			int cnt= pstmt.executeUpdate();
			
			
		} finally {
			dbUtil.close(conn,pstmt);
		}
		
	}

	@Override
	public void regist(BoardDto boardDto) throws SQLException {
		String sql="insert into board (user_id, subject, content)\r\n" + 
				"value(?, ?, ?);";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, boardDto.getUserId());
			pstmt.setString(2, boardDto.getSubject() );
			pstmt.setString(3, boardDto.getContent());
			
			int cnt= pstmt.executeUpdate();
			
			
		} finally {
			dbUtil.close(conn,pstmt);
		}
	}

	@Override
	public void modify(BoardDto boardDto) throws SQLException {
		String sql="update board\r\n" + 
				"set subject=?, content=?\r\n" + 
				"where user_id=?;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, boardDto.getSubject());
			pstmt.setString(2, boardDto.getContent());
			pstmt.setString(3, boardDto.getUserId());
			
			int cnt= pstmt.executeUpdate();
			
			
		} finally {
			dbUtil.close(conn,pstmt);
		}			
	}
}
```

Controller의 요청을 DAO로 전달하는 Service 
---
```
public class BoardDaoImpl implements BoardDao {
	private DBUtil dbUtil=DBUtil.getInstance();
	
	@Override
	public List<BoardDto> selectAll() throws SQLException {
		List<BoardDto> list=new ArrayList<>();
		String sql="select * from board;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDto boardDto=new BoardDto();
				boardDto.setArticleNo(rs.getInt("article_no"));
				boardDto.setUserId(rs.getString("user_id"));
				boardDto.setSubject(rs.getString("subject"));
				boardDto.setContent(rs.getString("content"));
				boardDto.setRegisterTime(rs.getString("register_time"));
				
				list.add(boardDto);
			}
			
			return list;
		} finally {
			dbUtil.close(conn,pstmt,rs);
		}
		
	}

	@Override
	public BoardDto selectByArticleNo(int articleNo) throws SQLException {
		BoardDto boardDto=new BoardDto();
		String sql="select * from board where article_no=?;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, articleNo);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				boardDto.setArticleNo(rs.getInt("article_no"));
				boardDto.setUserId(rs.getString("user_id"));
				boardDto.setSubject(rs.getString("subject"));
				boardDto.setContent(rs.getString("content"));
				boardDto.setRegisterTime(rs.getString("register_time"));
				
				return boardDto;
			}
			
			return null;
		} finally {
			dbUtil.close(conn,pstmt,rs);
		}
	}

	@Override
	public void deleteByArticleNo(int articleNo) throws SQLException {
		
		String sql="delete from board where article_no=?;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, articleNo);
			
			int cnt= pstmt.executeUpdate();
			
			
		} finally {
			dbUtil.close(conn,pstmt);
		}
		
	}

	@Override
	public void regist(BoardDto boardDto) throws SQLException {
		String sql="insert into board (user_id, subject, content)\r\n" + 
				"value(?, ?, ?);";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, boardDto.getUserId());
			pstmt.setString(2, boardDto.getSubject() );
			pstmt.setString(3, boardDto.getContent());
			
			int cnt= pstmt.executeUpdate();
			
			
		} finally {
			dbUtil.close(conn,pstmt);
		}
	}

	@Override
	public void modify(BoardDto boardDto) throws SQLException {
		String sql="update board\r\n" + 
				"set subject=?, content=?\r\n" + 
				"where user_id=?;";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		try {
			conn=dbUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, boardDto.getSubject());
			pstmt.setString(2, boardDto.getContent());
			pstmt.setString(3, boardDto.getUserId());
			
			int cnt= pstmt.executeUpdate();
			
			
		} finally {
			dbUtil.close(conn,pstmt);
		}				
	}
}
```
요청 처리를 제어하는 Controller
---
```
@WebServlet("/board")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService=new BoardServiceImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		
		switch (action) {
		case "list":
			list(request,response);
			break;
		case "view":
			view(request,response);
			break;
		case "delete":
			delete(request,response);
			break;
		case "mvregist":
			response.sendRedirect(request.getContextPath()+"/regist.jsp");
			break;
		case "regist":
			regist(request,response);
			break;
		case "mvModify":
			mvModify(request,response);
			break;
		case "modify":
			modify(request,response);
			break;
		default:
			break;
		}
		
	}


	private void mvModify(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("수정할 글 불러오기");
		int articleNo=Integer.parseInt(request.getParameter("articleNo"));
		
		BoardDto article=new BoardDto();
		try {
			article = boardService.selectByArticleNo(articleNo);
			if(article!=null) {
				System.out.println("조회한 글 : "+article);
				request.setAttribute("article", article);
				request.getRequestDispatcher("/modify.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	private void modify(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("글 수정 시작");
		BoardDto boardDto=new BoardDto();
		
		String userId=request.getParameter("userId");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		
		boardDto.setUserId(userId);
		boardDto.setSubject(subject);
		boardDto.setContent(content);
		
		try {
			boardService.modify(boardDto);
			response.sendRedirect(request.getContextPath()+"/board?action=list");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}


	private void regist(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("글 작성 시작");
		BoardDto boardDto=new BoardDto();
		
		String userId=request.getParameter("userId");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		
		boardDto.setUserId(userId);
		boardDto.setSubject(subject);
		boardDto.setContent(content);
		
		try {
			boardService.regist(boardDto);
			response.sendRedirect(request.getContextPath()+"/board?action=list");
		} catch (Exception e) {
			// TODO: handle exception
		}
	}


	private void delete(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("삭제 시작");
		int articleNo=Integer.parseInt(request.getParameter("articleNo"));
		
		try {
			boardService.deleteByArticleNo(articleNo);
			response.sendRedirect(request.getContextPath()+"/board?action=list");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}


	private void view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("글 상세 조회 시작");
		int articleNo=Integer.parseInt(request.getParameter("articleNo"));
		
		BoardDto article=new BoardDto();
		try {
			article = boardService.selectByArticleNo(articleNo);
			if(article!=null) {
				System.out.println("조회한 글 : "+article);
				request.setAttribute("article", article);
				request.getRequestDispatcher("/boardview.jsp").forward(request, response);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
	}


	private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("게시판 글 목록 조회 시작");
		try {
			List<BoardDto> boardList=boardService.selectAll();
			
			for(BoardDto b : boardList) {
				System.out.println("게시판 목록  = "+b);
			}
			request.setAttribute("boardList", boardList);
			request.getRequestDispatcher("/board.jsp").forward(request, response);
		} catch (SQLException e) {
			System.out.println("게시판 글 목록 조회 실패");
			e.printStackTrace();
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
```
게시판을 보여주는 board.jsp
---
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="icon" href="./assets/images/favicon.png" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

<!-- Latest compiled JavaScript -->
<script defer
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<link
	href="
https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css
"
	rel="stylesheet" />
<link rel="stylesheet" href="./assets/css/main.css" />
<link rel="stylesheet" href="./assets/css/board.css">
<script defer src="./assets/js/main.js"></script>
</head>
<body>


	<!-- 헤더 -->

	<%@ include file="/include/header.jsp"%>
	<!-- 상단 navbar end -->

	<section class="board">
		<div class="page-title">
			<div class="container">
				<h3>게시판</h3><br>
				<c:if test="${not empty sessionScope.memberInfo }">
				<button type="button" class="btn btn-blue" onclick="location.href='${pageContext.request.contextPath}/board?action=mvregist'">글 쓰기</button>
				</c:if>
				
			</div>
		</div>
		<div id="board-search">
			<div class="container">
				<div class="search-window">
					<form action="">
						<div class="search-wrap">
							<label for="search" class="blind">공지사항 내용 검색</label> <input
								id="search" type="search" name="" placeholder="검색어를 입력해주세요."
								value="">	
							<button type="submit" class="btn btn-dark">검색</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- board list area -->
		<div id="board-list">
			<div class="container">
				<table class="board-table">
					<thead>
						<tr>
							<th scope="col" class="th-num">번호</th>
							<th scope="col" class="th-title">제목</th>
							<th scope="col" class="th-date">등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${boardList}" var="item" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<th><a href="${pageContext.request.contextPath}/board?action=view&articleNo=${item.articleNo}">${item.subject}</a></th>
								<td>${item.registerTime}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

	</section>

	<footer>
		<div class="inner">
			<ul class="menu">
				<li><a href="">개인정보 처리방침</a></li>
				<li><a href="">홈페이지 이용약관</a></li>
				<li><a href="">위치정보 이용약관</a></li>
			</ul>
			<div class="btn-group">
				<a href="" class="btn btn--gold">회사 소개</a> <a href=""
					class="btn btn--gold">신규입점제의</a> <a href="" class="btn btn--gold">사이트
					맵</a>
			</div>
		</div>
	</footer>
</body>
</html>
```

글의 제목을 클릭했을때 나오는 상세보기 화면 boardview.jsp
---
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="icon" href="./assets/images/favicon.png" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

<!-- Latest compiled JavaScript -->
<script defer
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<link
	href="
https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css
"
	rel="stylesheet" />
<link rel="stylesheet" href="./assets/css/main.css" />
<link rel="stylesheet" href="./assets/css/board.css">
<script defer src="./assets/js/main.js"></script>
</head>
<body>


	<!-- 헤더 -->

	<%@ include file="/include/header.jsp"%>
	<!-- 상단 navbar end -->

	<section class="board">
		<div class="page-title">
			<div class="container">
				<h3>게시판</h3>
			</div>
		</div>

		<div id="board-search">
			<div class="container">
				<div class="col-lg-8 col-md-10 col-sm-12">
					<div class="row my-2">
						<h1 class="fs-3 fw-bold text-secondary px-5">${article.subject}</h1>
					</div>
					<div class="row">
						<div class="col-md-8">
							<div class="clearfix align-content-center">
								<img class="avatar me-2 float-md-start bg-light p-2"
									src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg" />
								<p>
									<span class="fw-bold">${article.userId}</span> <br /> <span
										class="text-secondary fw-light">
										${article.registerTime} </span>
								</p>
							</div>
						</div>
						<div class="col-md-4 align-self-center text-end"></div>
						<div class="divider mb-3"></div>
						<div class="text-secondary">${article.content}</div>
						<div class="divider mt-3 mb-3"></div>
						<div class="d-flex justify-content-end">
							<button type="button" id="btn-list"
								class="btn btn-outline-primary mb-3"
								onclick="location.href='${pageContext.request.contextPath}/board?action=list'">
								글목록</button>
								<c:set var="memberId" value="${sessionScope.memberInfo.userId}"></c:set>
								<c:set var="articleId" value="${article.userId}"></c:set>
							<c:if test="${memberId == articleId}">
								<button type="button" id="btn-mv-modify"
									class="btn btn-outline-success mb-3 ms-1"
									onclick="location.href='${pageContext.request.contextPath}/board?action=mvModify&articleNo=${article.articleNo }'"
									>글수정</button>
								<button type="button" id="btn-delete"
									class="btn btn-outline-danger mb-3 ms-1 "
									onclick="location.href='${pageContext.request.contextPath}/board?action=delete&articleNo=${article.articleNo }'">
									글삭제</button>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>

	</section>

	<footer>
		<div class="inner">
			<ul class="menu">
				<li><a href="">개인정보 처리방침</a></li>
				<li><a href="">홈페이지 이용약관</a></li>
				<li><a href="">위치정보 이용약관</a></li>
			</ul>
			<div class="btn-group">
				<a href="" class="btn btn--gold">회사 소개</a> <a href=""
					class="btn btn--gold">신규입점제의</a> <a href="" class="btn btn--gold">사이트
					맵</a>
			</div>
		</div>
	</footer>
</body>
</html>
```
글쓰기 버튼을 클릭했을때 나오는 글쓰기 화면 regist.jsp
---
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="icon" href="./assets/images/favicon.png" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

<!-- Latest compiled JavaScript -->
<script defer
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<link
	href="
https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css
"
	rel="stylesheet" />
<link rel="stylesheet" href="./assets/css/main.css" />
<link rel="stylesheet" href="./assets/css/board.css">
<script defer src="./assets/js/main.js"></script>
</head>
<body>


	<!-- 헤더 -->

	<%@ include file="/include/header.jsp"%>
	<!-- 상단 navbar end -->

	<section class="board">
		<div class="page-title">
			<div class="container d-flex justify-content-center flex row">
				<h3>글 쓰기</h3><br>
				
				<div class="col-lg-8 col-md-10 col-sm-12 " >
					<form id="form-register" method="POST" action="">
						<input type="hidden" name="action" value="write">
						<div class="mb-3">
							<label for="subject" class="form-label">제목 : </label> <input
								type="text" class="form-control" id="subject" name="subject"
								placeholder="제목..." />
						</div>
						<div class="mb-3">
							<label for="content" class="form-label">내용 : </label>
							<textarea class="form-control" id="content" name="content"
								rows="7"></textarea>
						</div>
						<div class="col-auto text-center">
							<button type="button" id="btn-register"
								class="btn btn-outline-primary mb-3">글작성</button>
							<button type="reset" class="btn btn-outline-danger mb-3">초기화</button>
						</div>
					</form>
				</div>
			</div>

		</div>



	</section>
	<script>
	 document.querySelector("#btn-register").addEventListener("click", function () {
	        if (!document.querySelector("#subject").value) {
	          alert("제목 입력!!");
	          return;
	        } else if (!document.querySelector("#content").value) {
	          alert("내용 입력!!");
	          return;
	        } else {
	          let form = document.querySelector("#form-register");
	          form.setAttribute("action", "${pageContext.request.contextPath}/board?action=regist&userId=${sessionScope.memberInfo.userId }");
	          form.submit();
	        }
	      });</script>

	<%@ include file="/include/footer.jsp"%>

```
글 수정버튼을 클릭시 나오는 글 수정화면 modify.jsp
---
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="icon" href="./assets/images/favicon.png" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" />

<!-- Latest compiled JavaScript -->
<script defer
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<link
	href="
https://cdn.jsdelivr.net/npm/reset-css@5.0.2/reset.min.css
"
	rel="stylesheet" />
<link rel="stylesheet" href="./assets/css/main.css" />
<link rel="stylesheet" href="./assets/css/board.css">
<script defer src="./assets/js/main.js"></script>
</head>
<body>


	<!-- 헤더 -->

	<%@ include file="/include/header.jsp"%>
	<!-- 상단 navbar end -->

	<section class="board">
		<div class="page-title">
			<div class="container d-flex justify-content-center flex row">
				<h3>글 수정</h3><br>
				
				<div class="col-lg-8 col-md-10 col-sm-12 " >
					<form id="form-register" method="POST" action="">
						<input type="hidden" name="action" value="write">
						<div class="mb-3">
							<label for="subject" class="form-label">제목 : </label> <input
								type="text" class="form-control" id="subject" name="subject"
								value="${article.subject }" />
						</div>
						<div class="mb-3">
							<label for="content" class="form-label">내용 : </label>
							<textarea class="form-control" id="content" name="content"
								rows="7" >${article.content }</textarea>
						</div>
						<div class="col-auto text-center">
							<button type="button" id="btn-register"
								class="btn btn-outline-primary mb-3">글 수정</button>
							<button type="reset" class="btn btn-outline-danger mb-3">초기화</button>
						</div>
					</form>
				</div>
			</div>

		</div>



	</section>
	<script>
	 document.querySelector("#btn-register").addEventListener("click", function () {
	        if (!document.querySelector("#subject").value) {
	          alert("제목 입력!!");
	          return;
	        } else if (!document.querySelector("#content").value) {
	          alert("내용 입력!!");
	          return;
	        } else {
	          let form = document.querySelector("#form-register");
	          form.setAttribute("action", "${pageContext.request.contextPath}/board?action=modify&userId=${sessionScope.memberInfo.userId }");
	          form.submit();
	        }
	      });</script>

	<%@ include file="/include/footer.jsp"%>

```

</details>
    

# ✅ 4. 지역별 관광지 찾기

### 👀 4.1. 실행화면

### 4.1.1 지역별 관광지 검색

![attraction.gif](README%204ad9456f389843ad81d58f4ddc44157a/attraction.gif)

### 4.1.2 지역별 관광지 검색(지도 활용)

![attraction2.gif](README%204ad9456f389843ad81d58f4ddc44157a/attraction2.gif)

## 4.2.  code

- 코드 펼치기

## Class Diagram

# 🧾 ERD

![ERD_enjoytrip.png](README%204ad9456f389843ad81d58f4ddc44157a/ERD_enjoytrip.png)
