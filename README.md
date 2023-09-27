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
