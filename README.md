# WODWarriors
#### ⚠️ **참고 : 디자인 패턴 공부중입니다. 기본적인 메인 기능들은 포함되어있지만, 개발 환경(Eclipse -> Intellij)의 변경과 대대적인 코드 리팩토링 진행 중입니다**

### 0.1 사용 기술 스택
**변경 전:**
- Eclipse(STS)
- Spring Framework
- OracleDB
- Javascript, HTML, CSS

**변경 진행 중:**
- Intellij
- Spring Boot
- MariaDB
- Javascript, Html, CSS
- JPA
- 적용되고 있는 디자인 패턴 : Decorator, factory method 패턴

## 1. 목표와 기능

### 1.1 목표
#### 와드워리어즈 웹 애플리케이션은 현대 사회에서 사람들을 모아 함께 운동할 수 있도록, 운동 종류와 위치를 공유하는 플랫폼입니다.

### 1.2 기능
- 로그인 & 회원가입
- 사용자가 원하는 운동 모임 개설 및 삭제
- 사용자가 지정한 위치를 기반으로 카카오맵에 운동 종류와 마커 표시
- 운동 모임 참여 및 미참여 선택 가능

## 2. 화면 설계
<table>
    <tbody>
        <tr>
            <td>메인</td>
            <td>로그인</td>
        </tr>
        <tr>
            <td>
                <img src="https://github.com/user-attachments/assets/438860fa-f15c-429f-a99c-517b89f62dd8" width="100%">
            </td>
            <td>
                <img src="https://github.com/user-attachments/assets/841c6d85-ad0a-4064-81be-002ff72da165" width="100%">
            </td>
        </tr>
	<tr>
            <td>회원가입</td>
            <td>비밀번호 찾기</td>
        </tr>
        <tr>
            <td>
                <img src="https://github.com/user-attachments/assets/4beea5ca-4210-4c84-b664-559b6f2661a5" width="100%">
            </td>
            <td>
                <img src="https://github.com/user-attachments/assets/00ec6ece-70ff-43ec-8c3c-bfb6512041f8" width="100%">
            </td>
        </tr>
	<tr>
            <td>지도</td>
            <td>위치선택</td>
        </tr>
        <tr>
            <td>
                <img src="https://github.com/user-attachments/assets/7b761480-a713-41ec-928b-7098d741c8bc" width="100%">
            </td>
            <td>
                <img src="https://github.com/user-attachments/assets/ed4de5c4-23f2-4db0-b23d-256168feca7a" width="100%">
            </td>
        </tr>
	<tr>
            <td>운동모임 개설</td>
            <td>운동위치선택(추후 위도 경도 값으로 전환됨)</td>
        </tr>
        <tr>
            <td>
                <img src="https://github.com/user-attachments/assets/e35cf360-99e9-40ac-bf05-4ca52a92eccd" width="100%">
            </td>
            <td>
                <img src="https://github.com/user-attachments/assets/20c97595-ea8b-4d32-be7a-fb8537348ee2" width="100%">
            </td>
        </tr>
    </tbody>
</table>


