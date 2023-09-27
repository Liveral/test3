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

### 1.1.3 정보 게시판바 Slide down

![메인페이지_게시판.png](README%204ad9456f389843ad81d58f4ddc44157a/%25EB%25A9%2594%25EC%259D%25B8%25ED%258E%2598%25EC%259D%25B4%25EC%25A7%2580_%25EA%25B2%258C%25EC%258B%259C%25ED%258C%2590.png)

## 1.2 💻 메인 화면 code

- 코드 펼치기
    
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
    

# ✅ 2. 로그인 기능

## 👀 2.1. 실행화면

### 2.1.1 회원가입

![Animation2.gif](README%204ad9456f389843ad81d58f4ddc44157a/Animation2.gif)

### 2.1.2 로그인

![Animation3.gif](README%204ad9456f389843ad81d58f4ddc44157a/Animation3.gif)

## 2.2. 💻 code

- 코드 펼치기
    
    public class MemberDaoImpl implements MemberDao {
    
    ```
    static private MemberDao memberDao = new MemberDaoImpl();
        static private DBUtil dbUtil = DBUtil.getInstance();
    
        private MemberDaoImpl() {}
    
        public static MemberDao getMemberDao() {
            return memberDao;
        }
    
        @Override
        public int registerMember(MemberDto memberDto) throws SQLException {
            Connection conn = null;
            PreparedStatement pstmt = null;
    
            String sql = "insert into member (user_name, user_id, user_pass, join_date)\r\n" +
                    "values (?, ?, ?, sysdate());";
    
            try {
                        conn = dbUtil.getConnection();
    
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, memberDto.getUserName() );
                        pstmt.setString(2, memberDto.getUserId() );
                        pstmt.setString(3, memberDto.getUserPass() );
    
                        return pstmt.executeUpdate();
                    } finally {
                        dbUtil.close(pstmt, conn);
                    }
        }
    
        @Override
        public MemberDto login(String userIdInput, String userPassInput) throws SQLException {
            MemberDto memberDto = null;
    
            String sql = "select *\r\n" +
                    "from member\r\n" +
                    "where user_id=? and user_pass=?;";
    
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = dbUtil.getConnection();
    
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setString(1, userIdInput);
                            pstmt.setString(2, userPassInput);
    
                            rs = pstmt.executeQuery();
    
                            if (rs.next()) {
                                String userName = rs.getString("user_name");
                                String userId = rs.getString("user_id");
                                String userPass = rs.getString("user_pass");
                                String joinDate = rs.getString("join_date");
    
                                memberDto = new MemberDto(userName, userId, userPass, joinDate);
                            }
                    } finally {
                        dbUtil.close(rs, pstmt, conn);
            }
    
            return memberDto;
        }
    
        @Override
        public int modifyMember(MemberDto memberDto) throws SQLException {
            Connection conn = null;
            PreparedStatement pstmt = null;
    
                    String sql = "update member\r\n" +
                        "set user_name=?, user_pass=?\r\n" +
                        "where user_id=?;";
    
                    try {
                        conn = dbUtil.getConnection();
    
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, memberDto.getUserName());
                        pstmt.setString(2, memberDto.getUserPass());
                        pstmt.setString(3, memberDto.getUserId() );
    
                        return pstmt.executeUpdate();
                    } finally {
                        dbUtil.close(pstmt, conn);
                    }
        }
    
        @Override
        public int deleteMember(String userId) throws SQLException {
            Connection conn = null;
            PreparedStatement pstmt = null;
    
                    String sql = "delete from member\n" +
                            "where user_id = ?;";
    
                    try {
                        conn = dbUtil.getConnection();
    
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, userId);
                        return pstmt.executeUpdate();
                    } finally {
                        dbUtil.close(pstmt, conn);
                    }
        }
    
    }
    ```
    

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

- 코드 펼치기
    
    public class BoardDaoImpl implements BoardDao {
    
    ```
    private static BoardDao boardDao = new BoardDaoImpl();
        private static DBUtil dbUtil = DBUtil.getInstance();
    
        private BoardDaoImpl() {}
    
        public static BoardDao getBoardDao() {
            return boardDao;
        }
    
        @Override
        public int registerArticle(BoardDto boardDto) throws SQLException {
            Connection conn = null;
            PreparedStatement pstmt = null;
    
            String sql = "insert into board (user_id, subject, content, register_time)\n" +
                    "values (?, ?, ?, sysdate());";
    
            try {
                conn = dbUtil.getConnection();
    
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, boardDto.getUserId() );
                pstmt.setString(2, boardDto.getSubject() );
                pstmt.setString(3, boardDto.getContent() );
    
                return pstmt.executeUpdate();
            } finally {
                dbUtil.close(pstmt, conn);
            }
        }
    
        @Override
        public List<BoardDto> searchListAll() throws SQLException {
            List<BoardDto> list = new ArrayList<BoardDto>();
    
            String sql = "select *\n" +
                    "from board\n" +
                    "order by article_no;";
    
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = dbUtil.getConnection();
    
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
    
                while(rs.next()) {
                    int articleNo = rs.getInt("article_no");
                    String userId = rs.getString("user_id");
                    String subject = rs.getString("subject");
                    String content = rs.getString("content");
                    int hit = rs.getInt("hit");
                    String registerTime = rs.getString("register_time");
    
                    BoardDto boardDto = new BoardDto(articleNo, userId, subject, content, hit, registerTime);
                    list.add(boardDto);
                }
            } finally {
                dbUtil.close(rs, pstmt, conn);
            }
    
            return list;
        }
    
        @Override
        public List<BoardDto> searchListBySubject(String subjectName) throws SQLException {
            List<BoardDto> list = new ArrayList<BoardDto>();
    
            String sql = "select *\n" +
                    "from board\n" +
                    "where subject like ?;";
    
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = dbUtil.getConnection();
    
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%"+subjectName+"%");
                rs = pstmt.executeQuery();
    
                while(rs.next()) {
                    int articleNo = rs.getInt("article_no");
                    String userId = rs.getString("user_id");
                    String subject = rs.getString("subject");
                    String content = rs.getString("content");
                    int hit = rs.getInt("hit");
                    String registerTime = rs.getString("register_time");
    
                    BoardDto boardDto = new BoardDto(articleNo, userId, subject, content, hit, registerTime);
                    list.add(boardDto);
                }
            } finally {
                dbUtil.close(rs, pstmt, conn);
            }
    
            return list;
        }
    
        @Override
        public BoardDto viewArticle(int no) throws SQLException {
            BoardDto boardDto = null;
    
            String selectSql = "select *\n" +
                    "from board\n" +
                    "where article_no = ?;";
            String hitCountSql = "update board\r\n" +
                    "set hit=?\r\n" +
                    "where article_no=?;";  // 조회수 1 증가시키는 쿼리
    
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = dbUtil.getConnection();
    
                pstmt = conn.prepareStatement(selectSql);
                pstmt.setInt(1, no);
                rs = pstmt.executeQuery();
    
                while(rs.next()) {
                    int articleNo = rs.getInt("article_no");
                    String subject = rs.getString("subject");
                    String content = rs.getString("content");
                    String userId = rs.getString("user_id");
                    int hit = rs.getInt("hit");
                    String registerTime = rs.getString("register_time");
    
                    boardDto = new BoardDto(articleNo, subject, content, userId, hit, registerTime);
    
                    // 조회수 증가
                    pstmt = conn.prepareStatement(hitCountSql);
                    pstmt.setInt(1,  hit+1);
                    pstmt.setInt(2, articleNo);
                    pstmt.executeUpdate();
                }
            } finally {
                dbUtil.close(rs, pstmt, conn);
            }
    
            return boardDto;
        }
    
        @Override
        public int modifyArticle(BoardDto boardDto) throws SQLException {
            String sql = "update board\n" +
                    "set subject=?, content=?\n" +
                    "where article_no=?;";
    
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = dbUtil.getConnection();
    
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, boardDto.getSubject());
                pstmt.setString(2, boardDto.getContent());
                pstmt.setInt(3, boardDto.getArticleNo());
                return pstmt.executeUpdate();
            } finally {
                dbUtil.close(rs, pstmt, conn);
            }
        }
    
        @Override
        public int deleteArticle(int no) throws SQLException {
            String sql = "delete from board\n" +
                    "where article_no=?;";
    
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                conn = dbUtil.getConnection();
    
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, no);
                return pstmt.executeUpdate();
            } finally {
                dbUtil.close(rs, pstmt, conn);
            }
        }
    }
    ```
    

## Class Diagram

# 🧾 ERD

![ERD_enjoytrip.png](README%204ad9456f389843ad81d58f4ddc44157a/ERD_enjoytrip.png)